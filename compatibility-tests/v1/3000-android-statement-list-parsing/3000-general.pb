# All the test cases in this group cover parsing of statement lists on Android
# app assets (i.e., inside of the APK package).  Specifically, this file
# contains tests that are not specific to a particular target asset type, and
# not specific to parsing of the relation string.

test_group: {
  name: 'comptest3001: statement list with valid statements (multiple statements and multiple relations)'
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3001.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls", "delegate_permission/common.get_user_location"],'
          '  "target" : { "namespace": "android_app", "package_name": "org.digitalassetlinks.comptest3001", "sha256_cert_fingerprints": ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"] }},'
          ' {"relation": [ "delegate_permission/common.get_login_creds" ],'
          '  "target" : { "namespace": "web", "site": "https://target-comptest3001.digitalassetlinks.org" }}] '
  }

  check_statements_tests: {
    name: 'Finds first relation.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3001.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3001'
        certificate {
          sha256_fingerprint: "14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"
        }
      } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'Finds second relation.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3001.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: 'delegate_permission/common.get_user_location'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3001'
        certificate {
          sha256_fingerprint: "14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"
        }
      } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'Finds web-to-web statement.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3001.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { web: { site: 'https://target-comptest3001.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'comptest3002: empty statement list'
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3002.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3002.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Empty statement list encountered'
    # No response field because we expect the list to be empty.
  }
}

test_group: {
  name: 'comptest3003: single invalid statement in statements list is skipped'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3003.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "web", "site": "https://target-comptest3003.digitalassetlinks.org"}, '
          '  "relation": ["delegate_permission/common.get_login_creds"]},     '
          ' {},                                                               '
          '{"relation": ["delegate_permission/common.handle_all_urls"],       '
          ' "target": {"namespace": "android_app",                            '
          '            "package_name": "org.digitalassetlinks.comptest3003",  '
          '            "sha256_cert_fingerprints":                            '
          '             ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                         '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3003.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { web: { site: 'https://target-comptest3003.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Could not parse (manifest|statement list)'
    response: true
  }

  check_statements_tests: {
    name: 'Test: Valid statement in the statement list should not be ignored.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3003.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3003'
        certificate: {
          sha256_fingerprint: '10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1'
        }
      } }
    }
    response: true
    outcome: FETCH_ERROR
    error_message_regex: 'Could not parse (manifest|statement list)'
  }

}

test_group: {
  name: 'comptest3004: include directives do not allow other standard fields'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3004.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "web", "site": "https://target-comptest3004.digitalassetlinks.org"}, '
          '  "include": "https://source-comptest3004.digitalassetlinks.org/includefile.json" }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3004.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'invalid field'
    # No response field because we expect the list to be empty.
  }
}

test_group: {
  name: 'comptest3005: include directives *do* allow other non-standard fields (for extensibility)'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3005.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"magicfield": {"foo": "bar"}, '
          '  "include": "https://source-comptest3005.digitalassetlinks.org/includefile.json" }]'
  }

  web_content: {
    url: 'https://source-comptest3005.digitalassetlinks.org/includefile.json'
    body: '[{"target": {"namespace": "web", "site": "https://target-comptest3005.digitalassetlinks.org"}, '
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3005.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { web: { site: 'https://target-comptest3005.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'comptest3006: statement list parsing fails when JSON is invalid (1)'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3006.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3006.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'not valid JSON'
  }
}

test_group: {
  name: 'comptest3007: statement list parsing uses strict JSON parsing mode (security requirement) (1)'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3007.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '42'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3007.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'not valid JSON'
  }
}

test_group: {
  name: 'comptest3008: statement list parsing uses strict JSON parsing mode (security requirement) (2)'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3008.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    # The comma in the relation array below implies a "dropped null
    # placeholder", which is not allowed in strict mode.
    assets_statements: '[{"relation": [ "delegate_permission/common.handle_all_urls", ], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3008.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3008.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'not valid JSON'
  }
}

test_group: {
  name: 'comptest3009: statement list must be encoded as a single JSON array'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3009.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '{"relation": [ "delegate_permission/common.handle_all_urls" ], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest3009.digitalassetlinks.org"} }'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3009.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'expected a single array'
  }
}

test_group: {
  name: 'comptest3010: statement list must be encoded as a JSON object'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3010.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '"foo"'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3010.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Could not parse (manifest|statement list)'
  }
}

test_group: {
  name: 'comptest3011: statement list must have a target'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3011.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": [ "delegate_permission/common.handle_all_urls" ]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3011.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'no target specified'
  }
}

test_group: {
  name: 'comptest3012: statement list must have a relation'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3012.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{ "target" : { "namespace": "web", "site": "https://target-comptest3012.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3012.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'no relation'
  }
}

test_group: {
  name: 'comptest3013: asset descriptors must be objects'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3013.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : "https://target-comptest3013.digitalassetlinks.org" }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3013.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'not an object'
  }
}

test_group: {
  name: 'comptest3014: asset descriptors must use a recognized namespace'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3014.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "internets", "site": "https://target-comptest3014.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3014.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'unrecognized namespace'
  }
}
