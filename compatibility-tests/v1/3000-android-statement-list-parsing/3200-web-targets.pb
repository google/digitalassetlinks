# All the test cases in this group cover parsing of statement lists on Android
# app assets (i.e., inside of the APK package).  Specifically, this file
# contains tests specific to parsing of web assets in the target field.

test_group: {
  name: 'comptest3201: statement list with a valid statement (typical case)'
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3201.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "web", "site": "https://target.digitalassetlinks.org"}, '
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3201.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { web: { site: 'https://target.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'comptest3202: statement list with a valid statement (fully qualified target)'
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3202.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "web", "site": "https://target.digitalassetlinks.org."}, '
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3202.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { web: { site: 'https://target.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'comptest3203: statement list with a valid statement (Mixed-case URL)'
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3203.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "web", "site": "HtTpS://target.digitalassetlinks.org"}, '
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3203.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { web: { site: 'https://target.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'comptest3204: web asset descriptors must have a URL'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3204.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web" } }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3204.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'no site field'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3205: web asset descriptors must contain valid URLs (the port number is invalid)'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3205.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://target.digitalassetlinks.org:999999"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3205.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'not a valid URL'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3206: web asset descriptors must contain HTTP or HTTPS URLs'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3206.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "mailto://user@digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3206.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'non-HTTP URL'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3207: web asset descriptors must contain URLs without login info'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3207.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://x:y@target.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3207.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'login information'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3208: web asset descriptors must contain URLs without query parameters'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3208.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://target.digitalassetlinks.org?bar"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3208.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'query parameters'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3209: web asset descriptors must contain URLs without fragment IDs'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3209.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://target.digitalassetlinks.org#bar"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3209.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'fragment identifiers'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3210: web asset descriptors must contain URLs without path components (1)'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3210.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://target.digitalassetlinks.org/"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3210.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'cannot contain a path'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3211: web asset descriptors must contain URLs without path components (2)'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3211.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://target.digitalassetlinks.org/XXX"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3211.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'cannot contain a path'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3212: web asset descriptors must contain URLs without path components (3)'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3212.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://target.digitalassetlinks.org/XXX/"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3212.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'cannot contain a path'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3213: web asset descriptors must contain URLs without path components (4)'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3213.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://target.digitalassetlinks.org/*"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3213.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'cannot contain a path'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3214: web asset descriptors must contain a scheme'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3214.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "target.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3214.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: '(Invalid site|Url is not well formatted)'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}
