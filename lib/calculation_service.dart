import 'dart:math';

int latToTileY(double lat, int zoom)
{
  final latRadian = lat * pi / 180.0;
  double e = 0.0818191908426;
  final int tileY = (((20037508.342789 -
                  6378137 *
                      log(tan(pi / 4 + latRadian / 2) /
                          pow(tan(pi / 4 + asin(e * sin(latRadian)) / 2), e))) *
              53.5865938 /
              pow(2, 23 - zoom)) /
          256)
      .floor();
  return tileY;
}

int longToTileX(double long, int zoom)
{
  final longRadian = long * pi / 180.0;
  final int tileX = (((20037508.342789 + 6378137 * longRadian) *
              53.5865938 /
              pow(2.0, 23 - zoom)) /
          256)
      .floor();
  return tileX;
}
