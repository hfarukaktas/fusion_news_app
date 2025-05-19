import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_news_app/core/common/utils/capitalize.dart';
import 'package:fusion_news_app/core/theme/app_palette.dart';
import 'package:fusion_news_app/features/auth/view/pages/login_page.dart';
import 'package:fusion_news_app/presentation/bloc/profile_page_bloc/profile_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(LoadProfile()),
      child: Scaffold(
        body: SafeArea(child: _buildProfileContent()),
        bottomNavigationBar: Container(
          height: 80,
          width: double.infinity,
          padding: EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: () => _signOut(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Pallete.backgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'Çıkış Yap',
              style: TextStyle(fontSize: 20, color: Pallete.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileContent() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is ProfileError) {
          return Center(child: Text(state.message));
        }

        if (state is ProfileLoaded) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: _buildUserInfo(state.userName, state.userEmail),
                ),
                const SizedBox(height: 24),

                const Text(
                  textAlign: TextAlign.center,
                  'Takip Edilen Kaynaklar',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                Expanded(child: _buildNewsSourcesList(state.newsSources)),
              ],
            ),
          );
        }
        return const Center(child: Text('Bilinmeyen bir durum oluştu'));
      },
    );
  }

  Widget _buildUserInfo(String name, String email) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          capitalize(name),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Pallete.backgroundColor,
          ),
        ),
        const SizedBox(height: 8),
        Text(email, style: const TextStyle(fontSize: 16, color: Colors.grey)),
      ],
    );
  }

  Widget _buildNewsSourcesList(List<String> sources) {
    if (sources.isEmpty) {
      return const Center(
        child: Text('Henüz hiç haber kaynağı takip etmiyorsunuz'),
      );
    }

    return ListView.builder(
      itemCount: sources.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: FutureBuilder<DocumentSnapshot>(
            future:
                FirebaseFirestore.instance
                    .collection('news_sources')
                    .doc(sources[index])
                    .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!.data() as Map<String, dynamic>;
                return Text(data['source'] ?? 'Bilinmeyen Kaynak');
              }
              return const Text('Yükleniyor...');
            },
          ),
          trailing: IconButton(
            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
            onPressed:
                () => context.read<ProfileBloc>().add(
                  RemoveNewsSource(sources[index]),
                ),
          ),
        );
      },
    );
  }

  void _signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
