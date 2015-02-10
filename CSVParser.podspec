Pod::Spec.new do |s|
  s.name = "CSVParser"
  s.version = "0.1"
  s.summary = "A CSV Parser for iOS and OSX"
  s.description = <<-DESC
                   * It can parse csv file into an array of arrays or an array of dictionaries.
                   * The csv file can contain single quote ' or double quote ".
                   DESC
  s.homepage = "https://github.com/ha-minh-vuong/CSVParser"
  s.license = {
    :type => 'BSD',
    :file => 'LICENSE'
  }
  s.platform = :ios, '7.0'
  s.source = {
    :git => 'https://github.com/ha-minh-vuong/CSVParser.git',
    :tag => s.version.to_s
  }
  s.source_files = 'CSVParser/Parser/*.{h,m}'
  s.frameworks = 'Foundation'
  s.requires_arc = true
end
