# Buildpack: libvips

This buildpack installs [libvips](https://www.libvips.org/) in your Scalingo container.

For now, these stacks are supported:

- scalingo-20

## Usage

Add the following buildpack to your `.buildpacks` file:

```
https://github.com/Frzk/sclng-solutions-engineer-buildpack.git
```

For example, if your app is written with Ruby on Rails, your `.buildpacks` file could look like this:

```
https://github.com/Frzk/sclng-solutions-engineer-buildpack.git
https://github.com/Scalingo/ruby-buildpack.git
```

And then you would just have to push your app to Scalingo to build and run it:

```bash
git push scalingo master
```

## Using a specific version of `libvips`

By default the buildpack will install the latest release of `libvips` to your application, but you can install a specific version of `libvips` by setting the `LIBVIPS_VERSION` environment variable to the desired value.

If the specified version hasn't been pre-compiled yet, you can fix this by yourself by generating the needed pre-compiled binaries (see [Builder script](#builder-script)).

### Builder script

The [`builder.sh`](builder.sh) script leverages Docker to compile and prepare an archive for a specific version of `libvips`. Since compiling is very time-consuming, it's smarter to compile it once and benefit from it thereafter.
After the tar file is built, it's placed in the [`compiled`](compiled) directory. Please `git commit` the new file to your buildpack fork repo so you can use it.

## Build configuration

`libvips` is compiled without installing optional dependencies. If you need a specific option, feel free to modify the [`builder/Dockerfile`](builder/Dockerfile) to suit your needs.

### scalingo-20
```
enable debug: no
enable deprecated library components: yes
enable modules: no
use fftw3 for FFT: no
accelerate loops with orc: no
ICC profile support with lcms: yes (lcms2)
zlib: yes
text rendering with pangocairo: no
font file support with fontconfig: 
RAD load/save: yes
Analyze7 load/save: yes
PPM load/save: yes
GIF load:  yes
GIF save with cgif: no
EXIF metadata support with libexif: yes
JPEG load/save with libjpeg: yes (pkg-config)
JXL load/save with libjxl: no (dynamic module: no)
JPEG2000 load/save with libopenjp2: no
PNG load with libspng: no
PNG load/save with libpng: yes (pkg-config libpng >= 1.2.9)
quantisation to 8 bit: no
TIFF load/save with libtiff: yes (pkg-config libtiff-4)
image pyramid save: no
HEIC/AVIF load/save with libheif: no (dynamic module: no)
WebP load/save with libwebp: no
PDF load with PDFium:  no
PDF load with poppler-glib: no (dynamic module: no)
SVG load with librsvg-2.0: yes
EXR load with OpenEXR: yes
OpenSlide load: no (dynamic module: no)
Matlab load with matio: no
NIfTI load/save with niftiio: no
FITS load/save with cfitsio: no
Magick package: MagickCore (dynamic module: no)
Magick API version: magick6
load with libMagickCore: yes
save with libMagickCore: yes
```


