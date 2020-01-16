require File.expand_path("lib/tty/tree/version", __dir__)

Gem::Specification.new do |spec|
  spec.name          = "tty-tree"
  spec.version       = TTY::Tree::VERSION
  spec.authors       = ["Piotr Murach"]
  spec.email         = ["piotr@piotrmurach.com"]
  spec.summary       = %q{Print directory or structured data in a tree like format.}
  spec.description   = %q{Print directory or structured data in a tree like format.}
  spec.homepage      = "https://piotrmurach.github.io/tty"
  spec.license       = "MIT"
  spec.metadata = {
    "allowed_push_host" => "https://rubygems.org",
    "bug_tracker_uri"   => "https://github.com/piotrmurach/tty-tree/issues",
    "changelog_uri"     => "https://github.com/piotrmurach/tty-tree/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://www.rubydoc.info/gems/tty-tree",
    "homepage_uri"      => spec.homepage,
    "source_code_uri"   => "https://github.com/piotrmurach/tty-tree"
  }
  spec.files         = Dir["lib/**/*", "README.md", "CHANGELOG.md", "LICENSE.txt"]
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.0.0"
  spec.extra_rdoc_files = ["README.md"]

  spec.add_development_dependency "bundler", ">= 1.14.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
end
