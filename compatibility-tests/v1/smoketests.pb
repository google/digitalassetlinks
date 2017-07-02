# The smoke test suite consists of a small number of tests that can be used to
# quickly verify that at least the most important aspects of an implementation
# are working properly.

test_group: {
  name: 'smoketests01: Simple statements issued by a website'
  web_content: {
    url: 'https://source-smoketests01.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "web", "site": "https://target-smoketests01.digitalassetlinks.org"},'
          '  "relation": ["delegate_permission/common.handle_all_urls"]}, '
          ' {"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.smoketests01", "sha256_cert_fingerprints": ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}, '
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Simple list request (1)'
    request: {
      source: { web: { site: 'https://source-smoketests01.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
    response: {
      source { web { site: "https://source-smoketests01.digitalassetlinks.org." } }
      relation: "delegate_permission/common.handle_all_urls"
      target { web { site: "https://target-smoketests01.digitalassetlinks.org." } }
    }
  }

  list_statements_tests: {
    name: 'Simple list request (2)'
    request: {
      source: { web: { site: 'https://source-smoketests01.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.get_login_creds'
    }
    outcome: SUCCESS
    response: {
      source { web { site: "https://source-smoketests01.digitalassetlinks.org." } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests01'
        certificate {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
  }

  list_statements_tests: {
    name: 'List request without relation'
    request: {
      source: { web: { site: 'https://source-smoketests01.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: {
      source { web { site: "https://source-smoketests01.digitalassetlinks.org." } }
      relation: "delegate_permission/common.handle_all_urls"
      target { web { site: "https://target-smoketests01.digitalassetlinks.org." } }
    }
    response: {
      source { web { site: "https://source-smoketests01.digitalassetlinks.org." } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests01'
        certificate {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
  }

  list_statements_tests: {
    name: 'List request with non-matching relation'
    request: {
      source: { web: { site: 'https://source-smoketests01.digitalassetlinks.org' } }
      relation: "delegate_permission/common.share_user_location"
    }
    outcome: SUCCESS
  }

  check_statements_tests: {
    name: 'Correct website-to-website match'
    request: {
      source: { web: { site: "https://source-smoketests01.digitalassetlinks.org" } }
      target: { web: { site: "https://target-smoketests01.digitalassetlinks.org" } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'Website-to-website mismatch: wrong port number'
    request: {
      source: { web: { site: "https://source-smoketests01.digitalassetlinks.org" } }
      target: { web: { site: "https://target-smoketests01.digitalassetlinks.org:8080" } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'Website-to-website mismatch: wrong protocol'
    request: {
      source: { web: { site: "https://source-smoketests01.digitalassetlinks.org" } }
      target: { web: { site: "http://target-smoketests01.digitalassetlinks.org" } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'Website-to-website mismatch: wrong relation'
    request: {
      source: { web: { site: "https://source-smoketests01.digitalassetlinks.org" } }
      target: { web: { site: "https://target-smoketests01.digitalassetlinks.org" } }
      relation: 'delegate_permission/common.get_login_creds'
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'Website-to-website mismatch: wrong source protocol'
    request: {
      source: { web: { site: "http://source-smoketests01.digitalassetlinks.org" } }
      target: { web: { site: "https://target-smoketests01.digitalassetlinks.org" } }
      relation: 'delegate_permission/common.get_login_creds'
    }
    outcome: FETCH_ERROR
    response: false
    error_message_regex: "404 Not Found"
    error_code: [ ERROR_CODE_FETCH_ERROR ]
  }

  check_statements_tests: {
    name: 'Correct website-to-android match'
    request: {
      source: { web: { site: "https://source-smoketests01.digitalassetlinks.org" } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests01'
        certificate {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'Website-to-android mismatch: wrong package name'
    request: {
      source: { web: { site: "https://source-smoketests01.digitalassetlinks.org" } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests01.invalid'
        certificate {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    outcome: SUCCESS
    response: false
  }

  check_statements_tests: {
    name: 'Website-to-android mismatch: wrong certificate'
    request: {
      source: { web: { site: "https://source-smoketests01.digitalassetlinks.org" } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests01'
        certificate {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
    }
    outcome: SUCCESS
    response: false
  }

}

test_group: {
  name: 'smoketests02: Simple statements issued by an Android app'

  android_content: {
    package_name: 'org.digitalassetlinks.smoketests02.source'
    cert_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
    assets_statements: '[{"target": {"namespace": "web", "site": "https://target-smoketests02.digitalassetlinks.org"},'
                       '  "relation": ["delegate_permission/common.handle_all_urls"]}, '
                       ' {"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.smoketests02.target", "sha256_cert_fingerprints": ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}, '
                       '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'List request matches (1)'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests02.source'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
    response: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests02.source'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
      relation: "delegate_permission/common.handle_all_urls"
      target { web { site: "https://target-smoketests02.digitalassetlinks.org." } }
    }
  }

  list_statements_tests: {
    name: 'List request matches (2)'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests02.source'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
      relation: 'delegate_permission/common.get_login_creds'
    }
    outcome: SUCCESS
    response: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests02.source'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests02.target'
        certificate {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
  }

  list_statements_tests: {
    name: 'List without relation'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests02.source'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
    }
    outcome: SUCCESS
    response: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests02.source'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
      relation: "delegate_permission/common.handle_all_urls"
      target { web { site: "https://target-smoketests02.digitalassetlinks.org." } }
    }
    response: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests02.source'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests02.target'
        certificate {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
  }

  list_statements_tests: {
    name: 'List with wrong certificate'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests02.source'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    outcome: SUCCESS
  }

  check_statements_tests: {
    name: 'Simple Check request (1)'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests02.source'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
      relation: "delegate_permission/common.handle_all_urls"
      target { web { site: "https://target-smoketests02.digitalassetlinks.org." } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'Simple Check request (2)'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests02.source'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests02.target'
        certificate {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'Check request with wrong certificate'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests02.source'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
      relation: "delegate_permission/common.handle_all_urls"
      target { web { site: "https://target-smoketests02.digitalassetlinks.org." } }
    }
    outcome: SUCCESS
    response: false
  }

}

test_group: {
  name: 'smoketests03: invalid JSON inside include does not invalidate assetlinks.json'

  web_content: {
    url: 'https://smoketests03.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"include": "https://smoketests03.digitalassetlinks.org/include.json"},'
          ' {"relation": ["delegate_permission/common.handle_all_urls"],       '
          '  "target": {"namespace": "android_app",                            '
          '     "package_name": "org.digitalassetlinks.target",                '
          '     "sha256_cert_fingerprints":                                    '
          '           ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                       '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}}]   '
  }

  web_content: {
    url: 'https://smoketests03.digitalassetlinks.org/include.json'
    body: 'INVALID_JSON'
  }

  check_statements_tests: {
    request: {
      source: { web: { site: 'https://smoketests03.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.target'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    outcome: FETCH_ERROR
    response: true
    error_message_regex: 'not valid JSON'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'smoketests04: invalid JSON inside include invalidates entire include'

  web_content: {
    url: 'https://smoketests04.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"include": "https://smoketests04.digitalassetlinks.org/include_invalid.json"},'
          ' {"include": "https://smoketests04.digitalassetlinks.org/include_valid.json"}]'
  }

  web_content: {
    url: 'https://smoketests04.digitalassetlinks.org/include_invalid.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"],       '
          '  "target": {"namespace": "android_app",                            '
          '     "package_name": "org.digitalassetlinks.target.invalid",        '
          '     "sha256_cert_fingerprints":                                    '
          '           ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                       '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}},   '
          '{INVALID_JSON}]   '
  }

  web_content: {
    url: 'https://smoketests04.digitalassetlinks.org/include_valid.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"],       '
          '  "target": {"namespace": "android_app",                            '
          '     "package_name": "org.digitalassetlinks.target.valid",          '
          '     "sha256_cert_fingerprints":                                    '
          '           ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                       '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}}]   '
  }

  check_statements_tests: {
    name: 'Test: Invalid JSON in include should invalidate entire include'
    request: {
      source: { web: { site: 'https://smoketests04.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.target.invalid'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    outcome: FETCH_ERROR
    response: false
    error_message_regex: 'not valid JSON'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }

  check_statements_tests: {
    name: 'Control: Valid include should work fine'
    request: {
      source: { web: { site: 'https://smoketests04.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.target.valid'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    outcome: FETCH_ERROR
    response: true
    error_message_regex: 'not valid JSON'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'smoketests05: invalid json at the first level results in empty statement list.'

  web_content: {
    url: 'https://smoketests05.digitalassetlinks.org/.well-known/assetlinks.json'
    body: 'INVALID-JSON'
  }

  check_statements_tests: {
    request: {
      source: { web: { site: 'https://smoketests05.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.target'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    outcome: FETCH_ERROR
    response: false
    error_message_regex: 'not valid JSON'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'smoketests06: recursive includes are resolved successfully'

  web_content: {
    url: 'https://smoketests06.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"include": "https://smoketests06.digitalassetlinks.org/include1.json"}]'
  }

  web_content: {
    url: 'https://smoketests06.digitalassetlinks.org/include1.json'
    body: '[{"include": "https://smoketests06.digitalassetlinks.org/include2.json"},'
          ' {"relation": ["delegate_permission/common.handle_all_urls"],       '
          '  "target": {"namespace": "android_app",                            '
          '             "package_name": "org.digitalassetlinks.target",        '
          '     "sha256_cert_fingerprints":                                    '
          '           ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                       '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}}]   '
  }

  web_content: {
    url: 'https://smoketests06.digitalassetlinks.org/include2.json'
    body: '[{"include": "https://smoketests06.digitalassetlinks.org/include1.json"}]'
  }

  check_statements_tests: {
    request: {
      source: { web: { site: 'https://smoketests06.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.target'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    outcome: FETCH_ERROR
    response: true
    error_message_regex: 'Fetch budget exhausted'
    error_code: [ ERROR_CODE_FETCH_BUDGET_EXHAUSTED ]
  }
}

test_group: {
  name: 'smoketests07: Ignore invalid statement in a statement list.'

  web_content: {
    url: 'https://smoketests07.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "web", "site": "unknown://target.digitalassetlinks.org"},'
           ' "relation": ["delegate_permission/common.handle_all_urls"]},      '
           '{"target": {"namespace": "web", "site": "https://target.digitalassetlinks.org/path"},'
           ' "relation": ["delegate_permission/common.handle_all_urls"]},      '
           '{"not_a_statement": "error"},                                      '
           '{"relation": ["delegate_permission/common.handle_all_urls"],       '
           ' "target": {"namespace": "android_app",                            '
           '            "package_name": "org.digitalassetlinks.target",        '
           '            "sha256_cert_fingerprints":                            '
           '             ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                          '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}}]'
  }

  check_statements_tests: {
    name: 'Test: Valid statement in the statement list should not be ignored.'
    request: {
      source: { web: { site: 'https://smoketests07.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.target'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    outcome: FETCH_ERROR
    response: true
    error_message_regex: 'Could not parse (manifest|statement list)'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'smoketests08: Matching queries where the source is an Android app asset.'

  android_content: {
    package_name: 'org.digitalassetlinks.smoketests08'
    cert_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
                       '  "target": {"namespace": "web", "site": "https://target14-smoketests08.digitalassetlinks.org"}}]'
  }

  android_content: {
    package_name: 'org.digitalassetlinks.smoketests08'
    cert_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
                       '  "target": {"namespace": "web", "site": "https://target10-smoketests08.digitalassetlinks.org"}}]'
  }

  list_statements_tests: {
    name: 'Test: statements about an app match with correct cert'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests08'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
    response: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests08'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
      relation: "delegate_permission/common.handle_all_urls"
      target { web { site: "https://target10-smoketests08.digitalassetlinks.org." } }
    }
  }

  list_statements_tests: {
    name: 'Test: statements about an app match with alternative cert'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests08'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
    response: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests08'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
      relation: "delegate_permission/common.handle_all_urls"
      target { web { site: "https://target14-smoketests08.digitalassetlinks.org." } }
    }
  }

  list_statements_tests: {
    name: 'Test: statements about an app do not match if package name is incorrect'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests08.incorrect'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
  }

  list_statements_tests: {
    name: 'Test: statements about an app do not match if cert is incorrect'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.smoketests08'
        certificate: {
          sha256_fingerprint: 'FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
  }
}

test_group: {
  name: 'smoketests09: statements valid only if assetlinks.json has a cert'
  web_content: {
    url: 'https://smoketests09.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"],       '
          '  "target": {"namespace": "android_app",                            '
          '     "package_name":"org.digitalassetlinks.target"                  '
          '}}]                                                                 '
  }

  check_statements_tests: {
    name: 'Test: statements about an app invalid if no cert info provided'
    request: {
      source: { web: { site: 'https://smoketests09.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.target'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    response: false
    outcome: FETCH_ERROR
    error_message_regex: 'no sha256_cert_fingerprints field in android app asset descriptor'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'smoketests10: Simple statements issued by an insecure website'
  web_content: {
    url: 'http://source-smoketests10.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "web", "site": "https://target-smoketests10.digitalassetlinks.org"},'
          '  "relation": ["delegate_permission/common.handle_all_urls"]}]'
  }

  list_statements_tests: {
    name: 'Simple list request'
    request: {
      source: { web: { site: 'http://source-smoketests10.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
    response: {
      source { web { site: "http://source-smoketests10.digitalassetlinks.org." } }
      relation: "delegate_permission/common.handle_all_urls"
      target { web { site: "https://target-smoketests10.digitalassetlinks.org." } }
    }
  }
}
