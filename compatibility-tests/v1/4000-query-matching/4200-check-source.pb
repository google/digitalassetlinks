# All the tests in this group cover matching of the 'source' field in Check()
# requests.

test_group: {
  name: 'comptest4201: Matching queries where the source is an Android app asset.'

  android_content: {
    package_name: 'org.digitalassetlinks.comptest4201'
    cert_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
                       '  "target": {"namespace": "web", "site": "https://target14-comptest4201.digitalassetlinks.org"}}]'
  }

  android_content: {
    package_name: 'org.digitalassetlinks.comptest4201'
    cert_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
                       '  "target": {"namespace": "web", "site": "https://target10-comptest4201.digitalassetlinks.org"}}]'
  }

  check_statements_tests: {
    name: 'Test: statements about an app match with correct cert'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest4201'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target10-comptest4201.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'Test: statements about an app match with alternative cert'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest4201'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target14-comptest4201.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'Test: statements about an app do not match with incorrect package name'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest4201.invalid'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target10-comptest4201.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'Test: statements about an app do not match with incorrect cert'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest4201'
        certificate: {
          sha256_fingerprint: 'FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target10-comptest4201.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: false
  }
}

test_group: {
  name: 'comptest4202: Matching queries where the source is a HTTP Web asset.'
  stub_environment_only: true  # Non-standard HTTP port used.
  web_content: {
    url: 'http://comptest4202.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target": {"namespace": "web", "site":"https://target-http-site-comptest4202.digitalassetlinks.org" }}]'
  }
  web_content: {
    url: 'https://comptest4202.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target": {"namespace": "web", "site":"https://target-https-site-comptest4202.digitalassetlinks.org" }}]'
  }
  web_content: {
    url: 'https://comptest4202.digitalassetlinks.org:444/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target": {"namespace": "web", "site":"https://target-custom-port-https-site-comptest4202.digitalassetlinks.org" }}]'
  }
  web_content: {
    url: 'http://comptest4202.digitalassetlinks.org:88/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target": {"namespace": "web", "site":"https://target-custom-port-http-site-comptest4202.digitalassetlinks.org" }}]'
  }


  check_statements_tests: {
    name: 'HTTP site matches HTTP request'
    request: {
      source: { web: { site: 'http://comptest4202.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-http-site-comptest4202.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'HTTP site matches HTTP request with explicit port'
    request: {
      source: { web: { site: 'http://comptest4202.digitalassetlinks.org:80' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-http-site-comptest4202.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'HTTP site does not match HTTPS request'
    request: {
      source: { web: { site: 'https://comptest4202.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-http-site-comptest4202.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'HTTPS site matches HTTPS request'
    request: {
      source: { web: { site: 'https://comptest4202.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-https-site-comptest4202.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'HTTPS site matches HTTPS request with explicit port'
    request: {
      source: { web: { site: 'https://comptest4202.digitalassetlinks.org:443' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-https-site-comptest4202.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'HTTPS site does not match HTTPS request with custom port'
    request: {
      source: { web: { site: 'https://comptest4202.digitalassetlinks.org:444' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-https-site-comptest4202.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'HTTPS site does not match HTTP request'
    request: {
      source: { web: { site: 'http://comptest4202.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-https-site-comptest4202.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'HTTPS site with custom port matches HTTPS request with custom port'
    request: {
      source: { web: { site: 'https://comptest4202.digitalassetlinks.org:444' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-custom-port-https-site-comptest4202.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'HTTPS site with custom port does not match HTTPS request'
    request: {
      source: { web: { site: 'https://comptest4202.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-custom-port-https-site-comptest4202.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'HTTPS site with custom port does not match HTTPS request with explicit port'
    request: {
      source: { web: { site: 'https://comptest4202.digitalassetlinks.org:443' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-custom-port-https-site-comptest4202.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'HTTPS site with custom port does not match HTTP request'
    request: {
      source: { web: { site: 'http://comptest4202.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-custom-port-https-site-comptest4202.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'HTTP site with custom port matches HTTP request with custom port'
    request: {
      source: { web: { site: 'http://comptest4202.digitalassetlinks.org:88' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-custom-port-http-site-comptest4202.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'HTTP site with custom port does not match HTTPS request'
    request: {
      source: { web: { site: 'https://comptest4202.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-custom-port-http-site-comptest4202.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'HTTP site with custom port does not match HTTPS request with explicit port'
    request: {
      source: { web: { site: 'https://comptest4202.digitalassetlinks.org:443' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-custom-port-http-site-comptest4202.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'HTTP site with custom port does not match HTTP request'
    request: {
      source: { web: { site: 'http://comptest4202.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-custom-port-http-site-comptest4202.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: false
  }
}
