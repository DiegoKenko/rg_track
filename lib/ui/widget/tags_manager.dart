import 'package:flutter/material.dart';
import 'package:rg_track/utils/types.dart';

class TagsManager<T extends Object> extends StatefulWidget {
  final List<T>? initialTags;
  final String Function(T value) parseTitle;
  final ModelAction<T>? onAdd;
  final ModelAction<T>? onRemove;
  final ModelAction<List<T>> onChange;
  final Future<List<T>>? fetchItems;
  final bool enable;
  final String label;
  final Decoration? decoration;
  final EdgeInsets padding;
  final EdgeInsets margin;

  TagsManager({
    Key? key,
    required this.parseTitle,
    required this.onChange,
    this.fetchItems,
    this.onAdd,
    this.onRemove,
    this.enable = true,
    this.decoration,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.all(0),
    this.label = "",
    List<T>? initialTags,
  })  : initialTags = initialTags ?? [],
        super(key: key);

  @override
  State<TagsManager> createState() => _TagsManagerState<T>();
}

class _TagsManagerState<T extends Object> extends State<TagsManager> {
  final List<T> _selectedTags = <T>[];
  final List _allTags = [];
  TextEditingController _inputCtrl = TextEditingController();
  FocusNode _inputFocus = FocusNode();

  final BoxDecoration _commonBoxDecoration = BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(4)),
      border: Border.all(color: Colors.black26));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_inputFocus.hasFocus) {
          _inputFocus.unfocus();
        } else {
          FocusScope.of(context).requestFocus(_inputFocus);
        }
      },
      child: Container(
        decoration: widget.decoration ?? _commonBoxDecoration,
        padding: widget.padding,
        margin: widget.margin,
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ..._selectedTags
                .map((e) => Chip(
                      label: Text(widget.parseTitle(e)),
                      onDeleted: () {
                        if (!widget.enable) return;
                        removeTag(e);
                      },
                    ))
                .toList(),
            SizedBox(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: Autocomplete<T>(
                onSelected: (model) {
                  _update(model);
                  _inputCtrl.clear();
                },
                optionsBuilder: (TextEditingValue textEditingValue) => _allTags
                    .where((e) {
                      return widget
                              .parseTitle(e)
                              .toLowerCase()
                              .contains(textEditingValue.text.toLowerCase()) &&
                          !_allTags.any((v) => e == v);
                    })
                    .cast<T>()
                    .toList(),
                optionsViewBuilder:
                    (BuildContext context, onSelected, Iterable<T> options) =>
                        Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    child: Container(
                      height: 180,
                      width: 300,
                      decoration: _commonBoxDecoration,
                      child: ListView(
                        shrinkWrap: true,
                        children: options
                            .map((e) => ListTile(
                                  title: Text(widget.parseTitle(e)),
                                  onTap: () => onSelected(e),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    onFieldSubmitted) {
                  _inputCtrl = textEditingController;
                  _inputFocus = focusNode;
                  return TextFormField(
                    controller: _inputCtrl,
                    focusNode: _inputFocus,
                    enableSuggestions: true,
                    maxLines: 2,
                    minLines: 1,
                    onChanged: (String value) => _handleRawTextInput(value),
                    onFieldSubmitted: (String value) =>
                        _handleRawTextInput(value),
                    enabled: widget.enable,
                    decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        label: Text(widget.label)),
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }

  void addTag(T item) {
    _selectedTags.add(item);
    setState(() {});
    widget.onAdd?.call(item);
    widget.onChange.call(_selectedTags);
  }

  void removeTag(T item) {
    _selectedTags.remove(item);
    setState(() {});
    widget.onRemove?.call(item);
    widget.onChange.call(_selectedTags);
  }

  final RegExp _newLineOrComma = RegExp(r"[,\n]");

  void _handleRawTextInput(String value) {
    if (value.trim().isEmpty) {
      _inputCtrl.clear();
      return;
    }
    if (value.contains(_newLineOrComma)) {
      _inputCtrl.clear();
      var item = _findItemByValue(value);
      _addItemIfNotNull(item);
    }
  }

  void _update(T model) {
    _selectedTags.add(model);
    _inputCtrl.clear();
    setState(() {});
  }

  T? _findItemByValue(String value) {
    List<String> values = value.split(" ");
    Iterable filteredTags = _allTags.where((element) {
      String title = widget.parseTitle(element);
      return values.any((String partValue) => title.contains(partValue));
    });
    if (filteredTags.isEmpty) return null;
    return filteredTags.first;
  }

  void _addItemIfNotNull(T? item) {
    if (item == null) return;
    _selectedTags.add(item);
    setState(() {});
  }
}
