import 'package:flutter/material.dart';
import '../utils/data.dart';
import '../theme/color.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('关于领路'),
        backgroundColor: AppColor.primary,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner Image
            AspectRatio(
              aspectRatio: 13 / 4,
              child: Image.network(
                ImageUrls.bannerImage,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[300],
                    child: Center(child: Icon(Icons.error)),
                  );
                },
              ),
            ),
            
            // Company Description
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  _buildDescriptionSection(
                    context,
                    CompanyInfo.description1,
                    ImageUrls.companyImage1,
                  ),
                  SizedBox(height: 24),
                  _buildDescriptionSection(
                    context,
                    CompanyInfo.description2,
                    ImageUrls.companyImage2,
                  ),
                ],
              ),
            ),
            
            // Contact Information
            Container(
              color: Colors.grey[200],
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '联系我们',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  SizedBox(height: 8),
                  _buildContactInfo(Icons.phone, CompanyInfo.phone),
                  _buildContactInfo(Icons.wechat, CompanyInfo.wechat),
                  _buildContactInfo(Icons.location_on, CompanyInfo.address),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDescriptionSection(BuildContext context, String text, String imageUrl) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 200,
                color: Colors.grey[300],
                child: Center(child: Icon(Icons.error)),
              );
            },
          ),
        ),
        SizedBox(height: 16),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildContactInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              child: Text(text),
            ),
          ),
        ],
      ),
    );
  }
}