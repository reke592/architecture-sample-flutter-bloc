import 'package:ddd_commons/ddd_commons.dart';
import 'package:ddd_ui/ddd_ui.dart';
import 'package:flutter/material.dart';
import 'package:issues/src/bloc/issue_list_bloc.dart';
import 'package:issues/src/presentation/issue_list/issue_list_tile.dart';

class IssueListView extends StatelessWidget {
  const IssueListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IssueListBloc, IssueListState>(
      builder: (context, state) {
        return Expanded(
          child: Column(
            children: [
              if (state.isLoading) const LinearProgressIndicator(),
              if (state.data.isEmpty && !state.isLoading)
                const Center(child: Text('No recent issues')),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => AppTheme.gap1,
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return IssueListTile(data: state.data[index]);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
