import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_lab/application/connection/connection_form/connection_form_bloc.dart';
import 'package:stream_lab/presentation/core/constants.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnectionFormBloc, ConnectionFormState>(
      builder: (context, state) {
        return ElevatedButton.icon(
          onPressed: () {
            if (!state.isSaved) {
              context
                  .read<ConnectionFormBloc>()
                  .add(const ConnectionFormEvent.saveButtonPressed());
            }
          },
          icon: state.isSubmitting
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : const Icon(
                  Icons.save,
                  color: Colors.white,
                ),
          label: const Text('Save'),
          style: kDefaultButtonStyle,
        );
      },
    );
  }
}
