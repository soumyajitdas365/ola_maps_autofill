import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/widgets.dart';
import 'package:ola_maps_autofill/api.dart';
import 'package:ola_maps_autofill/api_types.dart';
import 'package:ola_maps_autofill/models/auto_complete_response_model.dart';

export 'package:animated_custom_dropdown/custom_dropdown.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    this.canCloseOutsideBounds = true,
    this.closeDropDownOnClearFilterSearch = false,
    this.closedHeaderPadding,
    this.controller,
    this.decoration,
    this.disabledDecoration,
    this.enabled = true,
    this.excludeSelected = true,
    this.expandedHeaderPadding,
    this.futureRequestDelay,
    this.headerBuilder,
    this.hideSelectedFieldWhenExpanded = false,
    this.hintText,
    this.itemsListPadding,
    this.itemsScrollController,
    this.listItemPadding,
    this.maxlines = 1,
    this.noResultFoundBuilder,
    this.noResultFoundText,
    this.onChanged,
    this.overlayController,
    this.overlayHeight,
    this.searchHintText,
    this.searchRequestLoadingIndicator,
    this.visibility,
    required this.apiKey,
    this.apiType = const AutoComplete(),
  });

  /// Define your api key
  final String apiKey;

  /// Two types of api available
  ///  1. AutoComplete
  ///  2. SearchText
  ///
  /// Choose according to your requirements
  ///
  /// Default to AutoComplete
  final ApiType apiType;

  /// Scroll controller to access items list scroll behavior.
  final ScrollController? itemsScrollController;

  /// The [noResultFoundBuilder] that will be used to build area when there's no search results match.
  final Widget Function(BuildContext, String)? noResultFoundBuilder;

  /// Text that suggests what sort of data the dropdown represents.
  ///
  /// Default to "Select value".
  final String? hintText;

  /// Text that suggests what to search in the search field.
  ///
  /// Default to "Search".
  final String? searchHintText;

  /// Called when the item of the [CustomDropdown] should change.
  final void Function(AutoCompleteResponseModel? value)? onChanged;

  /// Hide the selected item from the [items] list.
  final bool excludeSelected;

  /// Can close [CustomDropdown] overlay by tapping outside.
  /// Here "outside" covers the entire screen.
  final bool canCloseOutsideBounds;

  /// Hide the header field when [CustomDropdown] overlay opened/expanded.
  final bool hideSelectedFieldWhenExpanded;

  /// Text that notify there's no search results match.
  ///
  /// Default to "No result found.".
  final String? noResultFoundText;

  /// Duration after which the [futureRequest] is to be executed.
  final Duration? futureRequestDelay;

  /// Text maxlines for header and list item text.
  final int maxlines;

  /// Padding for [CustomDropdown] header (closed state).
  final EdgeInsets? closedHeaderPadding;

  /// Padding for [CustomDropdown] header (opened/expanded state).
  final EdgeInsets? expandedHeaderPadding;

  /// Padding for [CustomDropdown] items list.
  final EdgeInsets? itemsListPadding;

  /// Padding for [CustomDropdown] each list item.
  final EdgeInsets? listItemPadding;

  /// Widget to display while search request loading.
  final Widget? searchRequestLoadingIndicator;

  /// [CustomDropdown] opened/expanded area height.
  /// Only applicable if items are greater than 4 otherwise adjust automatically.
  final double? overlayHeight;

  /// The [headerBuilder] that will be used to build [CustomDropdown] header field.
  final Widget Function(BuildContext, AutoCompleteResponseModel, bool)?
      headerBuilder;

  /// [CustomDropdown] decoration.
  /// Contain sub-decorations [SearchFieldDecoration], [ListItemDecoration] and [ScrollbarThemeData].
  final CustomDropdownDecoration? decoration;

  /// [CustomDropdown] enabled/disabled state.
  /// If disabled, you can not open the dropdown.
  final bool enabled;

  /// [CustomDropdown] disabled decoration.
  ///
  /// Note: Only applicable if dropdown is disabled.
  final CustomDropdownDisabledDecoration? disabledDecoration;

  /// [CustomDropdown] will close on tap Clear filter for all search
  /// and searchRequest constructors
  final bool closeDropDownOnClearFilterSearch;

  /// The [overlayController] allows you to explicitly handle the [CustomDropdown] overlay states (show/hide).
  final OverlayPortalController? overlayController;

  /// The [controller] that can be used to control [CustomDropdown] selected item.
  final SingleSelectController<AutoCompleteResponseModel?>? controller;

  /// Callback for dropdown [visibility].
  ///
  /// If both [visibility] and [overlayController] are provided, this callback never listens the changes of [overlayController].
  /// You have to explicitly check for [overlayController] visibility states using [overlayController.isShowing] property.
  final Function(bool)? visibility;
  @override
  Widget build(BuildContext context) {
    kApiKey = apiKey;
    return CustomDropdown.searchRequest(
        noResultFoundText: noResultFoundText,
        closedHeaderPadding: closedHeaderPadding,
        controller: controller,
        decoration: decoration,
        disabledDecoration: disabledDecoration,
        enabled: enabled,
        excludeSelected: excludeSelected,
        expandedHeaderPadding: expandedHeaderPadding,
        futureRequestDelay: futureRequestDelay,
        headerBuilder: headerBuilder,
        hideSelectedFieldWhenExpanded: hideSelectedFieldWhenExpanded,
        hintText: hintText,
        itemsListPadding: itemsListPadding,
        listItemPadding: listItemPadding,
        overlayController: overlayController,
        searchRequestLoadingIndicator: searchRequestLoadingIndicator,
        noResultFoundBuilder: noResultFoundBuilder,
        searchHintText: searchHintText,
        key: key,
        visibility: visibility,
        maxlines: maxlines,
        overlayHeight: overlayHeight,
        closeDropDownOnClearFilterSearch: closeDropDownOnClearFilterSearch,
        canCloseOutsideBounds: canCloseOutsideBounds,
        futureRequest: (query) {
          // if (apiType is SearchText) {
          //   return Api.searchText(
          //     query,
          //     location: (apiType as SearchText).location,
          //     radius: (apiType as SearchText).radius,
          //     size: (apiType as SearchText).size,
          //     types: (apiType as SearchText).types,
          //   );
          // } else if (apiType is AutoComplete) {
          return Api.autoComplete(query,
              location: (apiType as AutoComplete).location,
              radius: (apiType as AutoComplete).radius,
              strictbounds: (apiType as AutoComplete).strictbounds);
          // } else {
          //   return Api.autoComplete(
          //     query,
          //   );
          // }
        },
        onChanged: onChanged);
  }
}
