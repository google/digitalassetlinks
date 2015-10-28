# All tests in this group cover processing of include files in statement lists.

test_group: {
  name: 'comptest5001: include directive and include file'
  web_content: {
    url: 'https://source-comptest5001.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{ "include": "https://source-comptest5001.digitalassetlinks.org/valid_include.json" }]'
  }

  web_content: {
    url: 'https://source-comptest5001.digitalassetlinks.org/valid_include.json'
    body: '[{"target": {"namespace": "web", "site": "https://target-comptest5001.digitalassetlinks.org"}, '
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest5001.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { web: { site: 'https://target-comptest5001.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'comptest5002: invalid JSON inside include does not invalidate assetlinks.json'

  web_content: {
    url: 'https://source-comptest5002.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"include": "https://source-comptest5002.digitalassetlinks.org/invalid_include.json"},'
          ' {"relation": ["delegate_permission/common.handle_all_urls"],       '
          '  "target": {"namespace": "android_app",                            '
          '     "package_name": "org.digitalassetlinks.comptest5002",          '
          '     "sha256_cert_fingerprints":                                    '
          '           ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                       '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}}]   '
  }

  web_content: {
    url: 'https://source-comptest5002.digitalassetlinks.org/invalid_include.json'
    body: 'INVALID_JSON'
  }

  check_statements_tests: {
    request: {
      source: { web: { site: 'https://source-comptest5002.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest5002'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    response: true
    outcome: FETCH_ERROR
    error_message_regex: 'not valid JSON'
  }
}

test_group: {
  name: 'comptest5003: invalid JSON inside include invalidates entire include'

  web_content: {
    url: 'https://source-comptest5003.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"include": "https://include-comptest5003.digitalassetlinks.org/invalid_include.json"},'
          ' {"include": "https://include-comptest5003.digitalassetlinks.org/valid_include.json"}]'
  }

  web_content: {
    url: 'https://include-comptest5003.digitalassetlinks.org/invalid_include.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"],       '
          '  "target": {"namespace": "android_app",                            '
          '     "package_name": "org.digitalassetlinks.comptest5003.invalid",  '
          '     "sha256_cert_fingerprints":                                    '
          '           ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                       '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}},   '
          '{INVALID_JSON}]   '
  }

  web_content: {
    url: 'https://include-comptest5003.digitalassetlinks.org/valid_include.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"],       '
          '  "target": {"namespace": "android_app",                            '
          '     "package_name": "org.digitalassetlinks.comptest5003.valid",    '
          '     "sha256_cert_fingerprints":                                    '
          '           ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                       '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}}]   '
  }

  check_statements_tests: {
    name: 'Test: Invalid JSON in include should invalidate entire include'
    request: {
      source: { web: { site: 'https://source-comptest5003.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest5003.invalid'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    response: false
    outcome: FETCH_ERROR
    error_message_regex: 'not valid JSON'
  }

  check_statements_tests: {
    name: 'Control: Valid include should work fine'
    request: {
      source: { web: { site: 'https://source-comptest5003.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest5003.valid'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    response: true
    outcome: FETCH_ERROR
    error_message_regex: 'not valid JSON'
  }
}

test_group: {
  name: 'comptest5004: includes are resolved successfully'

  web_content: {
    url: 'https://source-comptest5004.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"include": "https://include-comptest5004.digitalassetlinks.org/valid_include.json"}]'
  }

  web_content: {
    url: 'https://include-comptest5004.digitalassetlinks.org/valid_include.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"],       '
          '  "target": {"namespace": "android_app",                            '
          '             "package_name": "org.digitalassetlinks.comptest5004",  '
          '     "sha256_cert_fingerprints":                                    '
          '           ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                       '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}}]   '
  }

  check_statements_tests: {
    request: {
      source: { web: { site: 'https://source-comptest5004.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest5004'
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
  name: 'comptest5005: recursive includes are resolved successfully'

  web_content: {
    url: 'https://comptest5005.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"include": "https://comptest5005.digitalassetlinks.org/valid_include.json"}]'
  }

  web_content: {
    url: 'https://comptest5005.digitalassetlinks.org/valid_include.json'
    body: '[{"include": "https://comptest5005.digitalassetlinks.org/loop_include.json"},'
          ' {"relation": ["delegate_permission/common.handle_all_urls"],       '
          '  "target": {"namespace": "android_app",                            '
          '             "package_name": "org.digitalassetlinks.comptest5005",  '
          '     "sha256_cert_fingerprints":                                    '
          '           ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                       '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}}]   '
  }

  web_content: {
    url: 'https://comptest5005.digitalassetlinks.org/loop_include.json'
    body: '[{"include": "https://comptest5005.digitalassetlinks.org/valid_include.json"}]'
  }

  check_statements_tests: {
    request: {
      source: { web: { site: 'https://comptest5005.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest5005'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    response: true
    outcome: FETCH_ERROR
    error_message_regex: 'Fetch budget exhausted'
  }
}

test_group: {
  name: 'comptest5006: secure web asset cannot reference insecure include file'

  web_content: {
    url: 'https://source-comptest5006.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"include": "http://include-comptest5006.digitalassetlinks.org/valid_include.json"}]'
  }

  web_content: {
    url: 'http://include-comptest5006.digitalassetlinks.org/valid_include.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"],       '
          '  "target": {"namespace": "android_app",                            '
          '             "package_name": "org.digitalassetlinks.comptest5006",  '
          '     "sha256_cert_fingerprints":                                    '
          '           ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                       '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}}]   '
  }

  list_statements_tests: {
    request: {
      source: { web: { site: 'https://source-comptest5006.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Insecure URL in fetch stack of secure asset'
  }
}

test_group: {
  name: 'comptest5007: secure Android asset cannot reference insecure include file'
  stub_environment_only: true  # Production test targets currently do not
                               # support include statements in Android APKs.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest5007.source'
    cert_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
    assets_statements: '[{"include": "http://include-comptest5007.digitalassetlinks.org/valid_include.json"}]'
  }

  web_content: {
    url: 'http://include-comptest5007.digitalassetlinks.org/valid_include.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"],       '
          '  "target": {"namespace": "android_app",                            '
          '             "package_name": "org.digitalassetlinks.comptest5007.target",'
          '     "sha256_cert_fingerprints":                                    '
          '           ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                       '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}}]   '
  }

  list_statements_tests: {
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest5007.source'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Insecure URL in fetch stack of secure asset'
  }
}

test_group: {
  name: 'comptest5008: insecure assets can use insecure include files'

  web_content: {
    url: 'http://source-comptest5008.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"include": "http://include-comptest5008.digitalassetlinks.org/valid_include.json"}]'
  }

  web_content: {
    url: 'http://include-comptest5008.digitalassetlinks.org/valid_include.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"],       '
          '  "target": {"namespace": "android_app",                            '
          '             "package_name": "org.digitalassetlinks.comptest5008",  '
          '     "sha256_cert_fingerprints":                                    '
          '           ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                       '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}}]   '
  }

  check_statements_tests: {
    request: {
      source: { web: { site: 'http://source-comptest5008.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest5008'
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
  name: 'comptest5009: secure include files cannot include insecure include files'

  web_content: {
    url: 'http://source-comptest5009.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"include": "https://include1-comptest5009.digitalassetlinks.org/include.json"}]'
  }

  web_content: {
    url: 'https://include1-comptest5009.digitalassetlinks.org/include.json'
    body: '[{"include": "http://include1-comptest5009.digitalassetlinks.org/include.json"}]'
  }

  web_content: {
    url: 'http://include2-comptest5009.digitalassetlinks.org/include.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"],       '
          '  "target": {"namespace": "android_app",                            '
          '             "package_name": "org.digitalassetlinks.comptest5009",  '
          '     "sha256_cert_fingerprints":                                    '
          '           ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                       '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}}]   '
  }

  list_statements_tests: {
    request: {
      source: { web: { site: 'http://source-comptest5009.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Insecure include file included by secure include file'
  }
}

