import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/ds/tree/tree.dart';
import '../../../shared/ds/tree/tree_node.dart';
import '../../domain/entities/asset_entity.dart';
import '../../domain/entities/filter_value_entity.dart';
import '../../domain/entities/location_entity.dart';
import '../../domain/enums/component_sensor_type.dart';
import '../../domain/enums/component_status.dart';
import '../../domain/repositories/assets_repository.dart';

class AssetsTreeController extends GetxController with StateMixin<Tree<FilterValueEntity>> {
  AssetsTreeController(this._assetsRepository);

  final AssetsRepository _assetsRepository;

  final searchInputFieldController = TextEditingController();

  final filterEnergySensors = false.obs;
  final filterSensorsWithCriticalStatus = false.obs;

  Tree<FilterValueEntity>? _tree;

  Timer? _searchTextDebounce;

  Future<void> initialize(String companyId) async {
    change(null, status: RxStatus.loading());

    searchInputFieldController.text = '';
    filterEnergySensors.value = false;
    filterSensorsWithCriticalStatus.value = false;

    final getLocationsResult = await _assetsRepository.getLocations(companyId);

    getLocationsResult.fold(
      (locations) async {

        final getAssetsResult = await _assetsRepository.getAssets(companyId);

        getAssetsResult.fold(
          (assets) => _buildTree(locations, assets),
          _onGetDataError
        );
      
      },
      _onGetDataError,
    );
  }

  void _onGetDataError(Exception exception) {
    change(null, status: RxStatus.error(exception.toString()));
  }

  void _buildTree(List<LocationEntity> locations, List<AssetEntity> assets) {
    final map = <String, TreeNode<FilterValueEntity>>{};
    final rootNodes = <TreeNode<FilterValueEntity>>[];

    // Map each location by its id
    for (var location in locations) {
      map[location.id] = TreeNode<FilterValueEntity>(FilterValueEntity(location));
    }

    // Map each asset by its id
    for (var asset in assets) {
      map[asset.id] = TreeNode<FilterValueEntity>(FilterValueEntity(asset));
    }

    // Connects each sub-location to its location parent
    // If the location has no parent, it will be added to the root nodes
    for (var location in locations) {
      if (map.containsKey(location.parentId)) {
        map[location.parentId]!.addChild(map[location.id]!);
      }
      else {
        rootNodes.add(map[location.id]!);
      }
    }

    // Connects each sub-asset to its asset parent
    // If the asset has no parent, it will be added to the root nodes
    for (var asset in assets) {
      if (map.containsKey(asset.locationId)) {
        map[asset.locationId]!.addChild(map[asset.id]!);
      }
      else if (map.containsKey(asset.parentId)) {
        map[asset.parentId]!.addChild(map[asset.id]!);
      }
      else {
        rootNodes.add(map[asset.id]!);
      }
    }

    _tree = Tree(rootNodes: rootNodes);

    _sortNodesChildren(_tree!);

    change(_tree, status: RxStatus.success());
  }

  /// Orders tree nodes to improve visualization
  void _sortNodesChildren(Tree tree) {
    tree.rootNodes.sort(_compareNodes);

    for (var node in tree.rootNodes) {

      // Run a BFS on the tree rooted by this node
      final queue = Queue<TreeNode>.from([node]);

      while (queue.isNotEmpty) {
        final front = queue.removeFirst();

        front.children.sort(_compareNodes);

        queue.addAll(front.children);
      }
    }
  }

  /// The node with the most children appears first.
  /// In case of a tie, the weight defined by [_getNodeWeightByValueType] is used
  int _compareNodes(TreeNode a, TreeNode b) {
    final orderByChildrenLength = b.children.length.compareTo(a.children.length);

    if (orderByChildrenLength == 0) {
      final aWeight = _getNodeWeightByValueType(a);
      final bWeight = _getNodeWeightByValueType(b);

      return aWeight.compareTo(bWeight);
    }

    return orderByChildrenLength;
  }

  /// Needed to order Location < Asset < Component
  int _getNodeWeightByValueType(TreeNode node) {
    if (node.value is LocationEntity) {
      return 0;
    }
    else if (node.value is AssetEntity) {
      if ((node.value as AssetEntity).sensorType == null) {
        return 1;
      }
    }
    return 2;
  }

  void onSearchTextChanged(String _) {
    if (_searchTextDebounce?.isActive ?? false) {
      _searchTextDebounce?.cancel();
    }

    _searchTextDebounce = Timer(
      const Duration(milliseconds: 500),
      _filter,
    );
  }

  void setFilterEnergySensors(bool value) {
    filterEnergySensors.value = value;
    _filter();
  }

  void setFilterSensorsWithCriticalStatus(bool value) {
    filterSensorsWithCriticalStatus.value = value;
    _filter();
  }

  Future<void> _filter() async {
    change(null, status: RxStatus.loading());

    // TODO: move it to a Isolate
    for (var root in _tree!.rootNodes) {
      _dfs(root);
    }

    change(_tree, status: RxStatus.success());
  }

  /// Performs a post-order traversal of the tree,
  /// defining which nodes will be filtered
  bool _dfs(TreeNode<FilterValueEntity> node) {
    var filterNode = false;

    for (var child in node.children) {
      filterNode |= _dfs(child);
    }

    if (!filterNode) {
      filterNode = _shouldFilterNode(node);
    }

    node.value.setFilter(filterNode);

    return filterNode;
  }

  /// Defines whether the node should be displayed based on the selected filters,
  /// without considering children
  bool _shouldFilterNode(TreeNode<FilterValueEntity> node) {
    final nodeValue = node.value.value;
    final searchText = searchInputFieldController.text;

    var searchTextFilter = true;
    var componentSensorTypeFilter = true;
    var componentStatusFilter = true;

    if (searchText.isNotEmpty) {
      searchTextFilter = nodeValue.toString().toLowerCase().contains(searchText.toLowerCase());
    }

    if (filterEnergySensors.value) {
      componentSensorTypeFilter = (nodeValue is AssetEntity) && nodeValue.sensorType == ComponentSensorType.energy;
    }

    if (filterSensorsWithCriticalStatus.value) {
      componentStatusFilter = (nodeValue is AssetEntity) && nodeValue.status == ComponentStatus.alert;
    }

    final result = searchTextFilter && componentSensorTypeFilter && componentStatusFilter;

    return result;
  }
}
