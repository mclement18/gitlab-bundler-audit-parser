# gitlab-bundler-audit-parser
Parser to make [bundler-audit](https://github.com/rubysec/bundler-audit) json output compliant with GitLab dependency scanning

## Installation
```bash
gem install gitlab-bundler-audit-parser
```

## Usage
The gem comes with an executbable `gitlab-bundler-audit-parser`. To use it, simply pass the JSON output of `bundler-audit` to the stdin of the command. If any vulnerabilities are present, the executable will exit with a code `1`.
```bash
cat bundler-audit.output.json | gitlab-bundler-audit-parser
```
Or piping the ouput of `bundler-audit` directly.
```bash
bundle exec bundler-audit check -F json | gitlab-bundler-audit-parser
```

By default, a `gl-dependency-scanning-report.json` file will be generated in current directory. A different path can be specified as the following:
```bash
cat bundler-audit.output.json | gitlab-bundler-audit-parser path/to/a/file
```
