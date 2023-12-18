import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_commons/src/widgets/cubit/g_dropdown_cubit.dart';
import 'package:flutter/material.dart';

/// {@template g_dropdown}
/// common dropdown widget that use global message bus to resolve selection items.
///
/// see: message_bus/topics.dart
///
/// sample usage:
/// ```dart
/// GDropdown<EmployeeDropdownOption>(
///   bloc: context.read<GDropdownCubit<EmployeeDropdownOption>>(),
///   onInit: (context) {
///     context.read<HRRepository>();
///     return EmployeeDropdownOptionRequest(sender: this);
///   },
///   itemAsString: (item) => item.name,
///   onChanged: (value) {
///     context.read<SampleFormBloc>().add(SetEmployee(value));
///   }
/// );
/// ```
/// {@endtemplate}
class GDropdown<T> extends StatelessWidget {
  final GDropdownCubit<T> bloc;

  /// use this method to context.read the lazy repository provider who's incharge for the [MessageBusEvent]
  final ListRequest<T> Function(BuildContext context) onInit;

  final String Function(T item) itemAsString;

  final DropdownMenuItem<T> Function(T item)? itemBuilder;

  final void Function(T? value)? onChanged;

  final void Function()? onTap;

  final bool isDense;
  final bool readOnly;

  /// {@macro g_dropdown}
  const GDropdown({
    super.key,
    required this.bloc,
    required this.onInit,
    required this.itemAsString,
    this.itemBuilder,
    this.onChanged,
    this.onTap,
    this.isDense = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GDropdownCubit<T>, GDropdownState<T>>(
      bloc: bloc,
      builder: (context, state) {
        if (state.isInitial) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            bloc.load(onInit(context));
          });
        }
        return DropdownButton<T>(
          items: itemBuilder != null
              ? state.data.map(itemBuilder!).toList()
              : state.data
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(itemAsString(e)),
                      ))
                  .toList(),
          isDense: isDense,
          onTap: state.isLoading || readOnly ? null : onTap,
          onChanged: state.isLoading || readOnly ? null : onChanged,
        );
      },
    );
  }
}
