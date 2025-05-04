import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wcycle_bd/helper/font_helper.dart';
import 'package:wcycle_bd/helper/pre_style.dart';
import 'package:wcycle_bd/model/news_model.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({super.key, required this.newsModel});

  final NewsModel newsModel;

  @override
  Widget build(BuildContext context) {
    Future<void> launchUrls() async {
      final Uri url = Uri.parse(newsModel.newsLink!);
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }

    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.blueGrey.withValues(alpha: 0.4),
                BlendMode.dstATop,
              ),
              image: CachedNetworkImageProvider(newsModel.ltSrc!)),
          color: Colors.white24,
          borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(5), right: Radius.circular(30))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        spacing: 2,
        children: [
          Flexible(
            child: Text(
              newsModel.newsTittle!,
              textAlign: TextAlign.center,
              style: FontHelper()
                  .bodyMedium(context)
                  .copyWith(color: Colors.white),
            ),
          ),
          const Gap(3),
          Flexible(
            child: Text(
                textAlign: TextAlign.center,
                style: GoogleFonts.spectral(
                    color: Colors.limeAccent, fontSize: 12),
                maxLines: 3,
                newsModel.newsDescription!),
          ),
          TextButton(
              onPressed: launchUrls,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Card(
                  color: Colors.black,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(normalGap),
                    child: Text(
                      newsModel.linkType!,
                      style: FontHelper()
                          .bodySmall(context)
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
