# frozen_string_literal: true

require_relative "lib/monadix/version"

Gem::Specification.new do |spec|
  spec.name = "monadix"
  spec.version = Monadix::VERSION
  spec.authors = ["Laertis Pappas"]
  spec.email = ["laertis.pappas@gmail.com"]

  spec.summary = "Result objects in Ruby"
  spec.description = "Result objects in Ruby"
  spec.homepage = "https://www.github.com/laertispappas/monadix"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.executables = []
  spec.require_paths = ["lib"]
end
