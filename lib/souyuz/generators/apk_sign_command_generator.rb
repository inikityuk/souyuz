module Souyuz
  # Responsible for building the apksigner command
  class ApkSignCommandGenerator
    class << self
      def generate
        android_package_path = Souyuz.cache[:build_android_package_path]
        android_package_dir = File.dirname(android_package_path)
        android_package_filename_with_extension = "#{File.basename(android_package_path, ".*")}-signed#{File.extname(android_package_path)}"
        Souyuz.cache[:signed_android_package_path] = "#{File.join("#{android_package_dir}", "#{android_package_filename_with_extension}")}"

        parts = prefix
        parts << detect_apksigner_executable
        parts += options
        parts << Souyuz.cache[:aligned_apk_path]
        parts += pipe

        parts
      end

      def prefix
        [""]
      end

      def detect_apksigner_executable
        apksigner = File.join(Souyuz.config[:buildtools_path], 'apksigner')

        apksigner
      end

      def options
        options = []
        options << "sign"
        options << "--verbose" if $verbose
        options << "--ks \"#{Souyuz.config[:keystore_path]}\""
        options << "--ks-pass \"pass:#{Souyuz.config[:keystore_password]}\""
        options << "--ks-key-alias \"#{Souyuz.config[:keystore_alias]}\""
        options << "--key-pass \"pass:#{Souyuz.config[:key_password]}\""
        options << "--out \"#{Souyuz.cache[:signed_android_package_path]}\""

        options
      end

      def pipe
        pipe = []

        pipe
      end
    end
  end
end
