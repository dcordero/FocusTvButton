Pod::Spec.new do |s|
  s.name = 'FocusTvButton'
  s.authors = { 'David Cordero' => 'dcorderoramirez@gmail.com'}
  s.version = '2.2.0'
  s.license = 'MIT'
  s.summary = 'Light wrapper of UIButton that allow extra customization for tvOS'
  s.homepage = 'https://github.com/dcordero/FocusTvButton'
  s.source = { :git => 'https://github.com/dcordero/FocusTvButton.git', :tag => s.version }
  s.tvos.deployment_target = '9.0'
  s.source_files = 'FocusTvButton/Source/*.swift'
end
