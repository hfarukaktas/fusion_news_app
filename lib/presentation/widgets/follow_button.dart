import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_news_app/core/theme/app_palette.dart';
import 'package:fusion_news_app/presentation/bloc/follow_bloc/follow_bloc.dart';
import 'package:fusion_news_app/presentation/bloc/follow_bloc/follow_event.dart';
import 'package:fusion_news_app/presentation/bloc/follow_bloc/follow_state.dart';

class FollowButton extends StatelessWidget {
  final String sourceId;

  const FollowButton({required this.sourceId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FollowBloc()..add(LoadFollowStatus(sourceId)),
      child: BlocBuilder<FollowBloc, FollowState>(
        builder: (context, state) {
          if (state is FollowLoading) {
            return const CircularProgressIndicator();
          }

          if (state is FollowLoaded) {
            final isFollowing = state.isFollowing;

            return SizedBox(
              width: 250,
              child: OutlinedButton(
                onPressed: () {
                  context.read<FollowBloc>().add(ToggleFollowStatus(sourceId));
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Pallete.backgroundColor, width: 2),
                  backgroundColor:
                      isFollowing ? Pallete.white : Pallete.backgroundColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                child: Text(
                  isFollowing
                      ? 'Remove from your Fusion'
                      : 'Add to your Fusion',
                  style:
                      isFollowing
                          ? TextStyle(color: Pallete.backgroundColor)
                          : TextStyle(color: Pallete.white),
                ),
              ),
            );
          }

          if (state is FollowError) {
            return Text(state.message);
          }

          return const SizedBox();
        },
      ),
    );
  }
}
