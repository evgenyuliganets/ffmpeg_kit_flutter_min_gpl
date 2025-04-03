Pod::Spec.new do |s|
  s.name             = 'ffmpeg_kit_flutter_min_gpl'
  s.version          = '6.0.3'
  s.summary          = 'FFmpeg Kit for Flutter'
  s.description      = 'A Flutter plugin for running FFmpeg and FFprobe commands.'
  s.homepage         = 'https://github.com/arthenica/ffmpeg-kit'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'ARTHENICA' => 'open-source@arthenica.com' }

  s.platform            = :ios
  s.requires_arc        = true
  s.static_framework    = true

  s.source              = { :path => '.' }
  s.source_files        = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'

  s.default_subspec = 'min-gpl'

  s.dependency          'Flutter'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }

  # === CUSTOMIZED SUBSPEC USING LOCAL FRAMEWORKS ===
  s.subspec 'min-gpl' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'

    # Custom local framework setup (replaces original dependency)
    ss.ios.vendored_frameworks = [
      'Frameworks/ffmpegkit.framework',
      'Frameworks/libavcodec.framework',
      'Frameworks/libavdevice.framework',
      'Frameworks/libavfilter.framework',
      'Frameworks/libavformat.framework',
      'Frameworks/libavutil.framework',
      'Frameworks/libswresample.framework',
      'Frameworks/libswscale.framework'
    ]

    ss.ios.frameworks = 'AudioToolbox', 'CoreMedia'
    ss.libraries = 'z', 'bz2', 'c++', 'iconv'
    ss.ios.deployment_target = '10'

    # Pre-install hook to download and unzip frameworks if missing
    s.prepare_command = <<-CMD
      if [ ! -d "./Frameworks" ]; then
        chmod +x ../scripts/setup_ios.sh
        ../scripts/setup_ios.sh
      fi
    CMD
  end

  # You can keep or delete the rest depending on whether you're using them

  s.subspec 'min' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-min', "6.0"
    ss.ios.deployment_target = '12.1'
  end

  s.subspec 'min-lts' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-min', "6.0.LTS"
    ss.ios.deployment_target = '10'
  end

  s.subspec 'min-gpl-lts' do |ss|
    ss.source_files         = 'Classes/**/*'
    ss.public_header_files  = 'Classes/**/*.h'
    ss.dependency 'ffmpeg-kit-ios-min-gpl', "6.0.LTS"
    ss.ios.deployment_target = '10'
  end

  # Leave other subspecs untouched unless you need them locally too
end
