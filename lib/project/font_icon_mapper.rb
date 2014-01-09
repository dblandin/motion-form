module MotionForm
  module FontIconMapper
    class << self
      def call(icon)
        unicode(icon).hex.chr(Encoding::UTF_8)
      end

      def unicode(icon)
        mappings[icon] || ''
      end

      def mappings
        @mappings ||= begin
          path = NSBundle.mainBundle.pathForResource('icons', ofType:'json')
          data = NSData.dataWithContentsOfFile(path)

          NSJSONSerialization.JSONObjectWithData(data, options: 0, error: nil)
        end
      end
    end
  end
end
