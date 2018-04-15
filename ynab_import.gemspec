# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ynab_import/version'

Gem::Specification.new do |spec|
  spec.name          = "ynab_import"
  spec.version       = YnabImport::VERSION
  spec.authors       = ["Jens Balvig"]
  spec.email         = ["jens@balvig.com"]

  spec.summary       = %q{Converts bank CSV to be compatible with YNAB import}
  spec.description   = %q{Converts bank CSV to be compatible with YNAB import}
  spec.homepage      = "https://github.com/balvig/ynab_import"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"

  spec.add_dependency "google_currency"
  spec.add_dependency "terminal-table", "~> 1.6"
  spec.add_dependency "puma", "~> 3.0"
  spec.add_dependency "sinatra", "~> 2.0"
end
