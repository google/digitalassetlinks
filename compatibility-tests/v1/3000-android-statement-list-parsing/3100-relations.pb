# All the test cases in this group cover parsing of statement lists on Android
# app assets (i.e., inside of the APK package).  Specifically, this file
# contains tests specific to parsing of the relation string.

test_group: {
  name: 'comptest3101: valid relation string in statement lists (1)'

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3101.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3101.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3101.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: SUCCESS
    response: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3101.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: "delegate_permission/common.handle_all_urls"
      target { web { site: "https://target-comptest3101.digitalassetlinks.org." } }
    }
  }
}

test_group: {
  name: 'comptest3102: valid relation string in statement lists (2)'

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3102.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/write_on_the_walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3102.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3102.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: SUCCESS
    response: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3102.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: "delegate_permission/write_on_the_walls"
      target { web { site: "https://target-comptest3102.digitalassetlinks.org." } }
    }
  }
}

test_group: {
  name: 'comptest3103: valid relation string in statement lists (3)'

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3103.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/org.digitalassetlinks.write_on_the_walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3103.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3103.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: SUCCESS
    response: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3103.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: "delegate_permission/org.digitalassetlinks.write_on_the_walls"
      target { web { site: "https://target-comptest3103.digitalassetlinks.org." } }
    }
  }
}

test_group: {
  name: 'comptest3104: valid relation string in statement lists (4)'

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3104.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["navigate/yellow_brick_road"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3104.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3104.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: SUCCESS
    response: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3104.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: "navigate/yellow_brick_road"
      target { web { site: "https://target-comptest3104.digitalassetlinks.org." } }
    }
  }
}

test_group: {
  name: 'comptest3105: valid relation string in statement lists (5)'

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3105.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/get_login_creds"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3105.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3105.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: SUCCESS
    response: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3105.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: "delegate_permission/get_login_creds"
      target { web { site: "https://target-comptest3105.digitalassetlinks.org." } }
    }
  }
}

# Now some invalid queries.
test_group: {
  name: 'comptest3106: missing relation string in statement list'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3106.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{ "target" : { "namespace": "web", "site": "https://target-comptest3106.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3106.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'no relation array specified'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3107: Relation must be non-empty'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3107.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": [""], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3107.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3107.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid relation string'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3108: relations must be given as an array'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3108.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": "delegate_permission/common.handle_all_urls", '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3108.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3108.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'not an array'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3109: individual relations must be strings'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3109.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": [ {} ], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3109.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3109.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'invalid relation'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3110: relations must not have wildcards'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3110.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/*"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3110.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3110.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3111: relation string with invalid kind (1)'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3111.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["INVALID_KIND/write_on_the_walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3111.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3111.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3112: relation string with invalid kind (2)'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3112.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["/write_on_the_walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3112.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3112.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3113: relation string with invalid kind (3)'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3113.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["/"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3113.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3113.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3114: invalid relation string (1)'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3114.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["write_on_the_walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3114.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3114.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid relation string'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3115: invalid relation string (2)'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3115.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3115.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3115.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid relation string'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3116: invalid relation string (3)'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3116.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/write_on_the_walls/foo"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3116.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3116.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid relation string'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3117: invalid relation string (4)'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3117.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission,write_on_the_walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3117.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3117.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid relation string'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3118: relation string with invalid detail (1)'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3118.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3118.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3118.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3119: relation string with invalid detail (2)'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3119.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/write on the walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3119.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3119.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3120: relation string with invalid detail (3)'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3120.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/write+on+the+walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3120.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3120.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3121: relation string with invalid detail (4)'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3121.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/write_on_the_walls!"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3121.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3121.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3122: relation string with invalid detail (5)'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3122.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/write_on_the_WALLS"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3122.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3122.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3123: relation string with spurious whitespace (1)'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3123.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/write_on_the_walls "], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3123.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3123.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'detail\' field in relation string'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3124: relation string with spurious whitespace (2)'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3124.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": [" delegate_permission/write_on_the_walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3124.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3124.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3125: relation string with spurious whitespace (3)'
  stub_environment_only: true  # The API parses APK statements offline.

  android_content: {
    package_name: 'org.digitalassetlinks.comptest3125.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission / write_on_the_walls"], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3125.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3125.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Invalid \'kind\' field in relation string'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}
