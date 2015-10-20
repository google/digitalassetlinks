# All the tests in this group cover matching of the 'target' field in Check()
# requests.

test_group: {
  name: 'comptest4401: Matching queries where the target is an Android app asset.'

  web_content: {
    url: 'https://comptest4401.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"],       '
          '  "target": {"namespace": "android_app",                            '
          '     "package_name":"org.digitalassetlinks.comptest4401",           '
          '     "sha256_cert_fingerprints":                                    '
          '           ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                       '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1",      '
          '            "FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:'
                       '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}}]   '
  }

  check_statements_tests: {
    name: 'Test: statements about an app are valid with correct cert'
    request: {
      source: { web: { site: 'https://comptest4401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest4401'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'Test: statements about an app are invalid with incorrect package name.'
    request: {
      source: { web: { site: 'https://comptest4401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest4401.invalid'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'Test: statements about an app are invalid if cert does not match'
    request: {
      source: { web: { site: 'https://comptest4401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest4401'
        certificate: {
          sha256_fingerprint: 'AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA:AA'
        }
      } }
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'Test: statements about an app are valid with alternative cert'
    request: {
      source: { web: { site: 'https://comptest4401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest4401'
        certificate: {
          sha256_fingerprint: 'FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'web: statements valid only if assetlinks.json has a cert'
  web_content: {
    url: 'https://bad-comptest4402.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"],       '
          '  "target": {"namespace": "android_app",                            '
          '     "package_name":"org.digitalassetlinks.comptest4402"            '
          '}}]                                                                 '
  }

  web_content: {
    url: 'https://good-comptest4402.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"],       '
          '  "target": {"namespace": "android_app",                            '
          '     "package_name":"org.digitalassetlinks.comptest4402",           '
          '     "sha256_cert_fingerprints":                                    '
          '           ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                       '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]      '
          '}}]                                                                 '
  }

  check_statements_tests: {
    name: 'Test: statements about an app invalid if no cert info provided'
    request: {
      source: { web: { site: 'https://bad-comptest4402.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest4402'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    outcome: FETCH_ERROR
    response: false
    error_message_regex: 'no sha256_cert_fingerprints field in android app asset descriptor'
  }

  check_statements_tests: {
    name: 'Control: statements about an app are valid with cert info'
    request: {
      source: { web: { site: 'https://good-comptest4402.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest4402'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'comptest4403: Matching queries where the target is a HTTP Web asset.'
  web_content: {
    url: 'https://comptest4403.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target": {"namespace": "web", "site":"http://target-http-site-comptest4403.digitalassetlinks.org" }}]'
  }

  check_statements_tests: {
    name: 'HTTP site matches HTTP request'
    request: {
      source: { web: { site: 'https://comptest4403.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'http://target-http-site-comptest4403.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'HTTP site matches HTTP request with explicit port'
    request: {
      source: { web: { site: 'https://comptest4403.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'http://target-http-site-comptest4403.digitalassetlinks.org:80' } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'HTTP site does not match HTTPS request'
    request: {
      source: { web: { site: 'https://comptest4403.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-http-site-comptest4403.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'HTTP site does not match request with non-standard port'
    request: {
      source: { web: { site: 'https://comptest4403.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'http://target-http-site-comptest4403.digitalassetlinks.org:8080' } }
    }
    outcome: SUCCESS
    response: false
  }
}

test_group: {
  name: 'comptest4404: Matching queries where the target is a HTTPS Web asset.'
  web_content: {
    url: 'https://comptest4404.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target": {"namespace": "web", "site":"https://target-https-site-comptest4404.digitalassetlinks.org" }}]'
  }

  check_statements_tests: {
    name: 'HTTPs site matches HTTPs request'
    request: {
      source: { web: { site: 'https://comptest4404.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-https-site-comptest4404.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'HTTPs site matches HTTPs request with explicit port'
    request: {
      source: { web: { site: 'https://comptest4404.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-https-site-comptest4404.digitalassetlinks.org:443' } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'HTTPs site does not match HTTP request'
    request: {
      source: { web: { site: 'https://comptest4404.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'http://target-https-site-comptest4404.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'HTTPs site does not match request with non-standard port'
    request: {
      source: { web: { site: 'https://comptest4404.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-https-site-comptest4404.digitalassetlinks.org:8080' } }
    }
    outcome: SUCCESS
    response: false
  }
}

test_group: {
  name: 'comptest4405: Matching queries where the target is a HTTPS Web asset with explicit port.'
  web_content: {
    url: 'https://comptest4405.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target": {"namespace": "web", "site":"https://target-explicitport443-comptest4405.digitalassetlinks.org:443" }}]'
  }

  check_statements_tests: {
    name: 'site matches HTTPS request without explicit port'
    request: {
      source: { web: { site: 'https://comptest4405.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-explicitport443-comptest4405.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'site matches HTTPS request with explicit port'
    request: {
      source: { web: { site: 'https://comptest4405.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-explicitport443-comptest4405.digitalassetlinks.org:443' } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'site does not match HTTP request'
    request: {
      source: { web: { site: 'https://comptest4405.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'http://target-explicitport443-comptest4405.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'site does not match HTTP request with explicit port'
    request: {
      source: { web: { site: 'https://comptest4405.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'http://target-explicitport443-comptest4405.digitalassetlinks.org:443' } }
    }
    outcome: SUCCESS
    response: false
  }
}

test_group: {
  name: 'comptest4406: Matching queries where the target is a HTTPS Web asset with non-standard port.'
  web_content: {
    url: 'https://comptest4406.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target": {"namespace": "web", "site":"https://target-port444-comptest4406.digitalassetlinks.org:444" }}]'
  }

  check_statements_tests: {
    name: 'site matches HTTPS request with explicit port'
    request: {
      source: { web: { site: 'https://comptest4406.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-port444-comptest4406.digitalassetlinks.org:444' } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'site does not match HTTPS request with implicit port'
    request: {
      source: { web: { site: 'https://comptest4406.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-port444-comptest4406.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'site does not match HTTP request with explicit port'
    request: {
      source: { web: { site: 'https://comptest4406.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'http://target-port444-comptest4406.digitalassetlinks.org:444' } }
    }
    outcome: SUCCESS
    response: false
  }
}

