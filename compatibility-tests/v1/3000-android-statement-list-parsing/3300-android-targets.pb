# All the test cases in this group cover parsing of statement lists on Android
# app assets (i.e., inside of the APK package).  Specifically, this file
# contains tests specific to parsing of Android app assets in the target field.

test_group: {
  name: 'comptest3301: statement list with a valid statement (target is an Android app)'
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3301.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest3301", "sha256_cert_fingerprints": ["00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00"]}, "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3301.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3301'
        certificate {
          sha256_fingerprint: "00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00"
        }
      } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'comptest3302: statement list with a valid statement (target is an Android app with two certificates)'
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3302.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest3302", "sha256_cert_fingerprints": ["11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11", "22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22"]}, "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3302.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3302'
        certificate {
          sha256_fingerprint: "11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11"
        }
      } }
    }
    outcome: SUCCESS
    response: true
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3302.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3302'
        certificate {
          sha256_fingerprint: "22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22"
        }
      } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'comptest3303: Android app asset descriptors must have a package name'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3303.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "android_app", "sha256_cert_fingerprints": ["00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00"]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3303.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'no package_name field'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3304: Android app asset descriptors must have a certificate fingerprint'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3304.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest3304"},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3304.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'sha256_cert_fingerprints'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3305: Certificate fingerprints in Android app asset descriptors must be given as an array'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3305.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest3305", '
          '    "sha256_cert_fingerprints": "00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00"},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3305.source'
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
  name: 'comptest3306: Individual certificate fingerprints in Android app asset descriptors must be strings'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3306.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest3306", '
          '    "sha256_cert_fingerprints": [{}] },'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3306.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'sha256_cert_fingerprints'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3307: Android app asset descriptors must have a non-empty package name'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3307.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "android_app", "package_name": "", '
          '    "sha256_cert_fingerprints": ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3307.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'invalid package name'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3308: Android app asset descriptors must have a valid package name'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3308.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "android_app", "package_name": "B A D", '
          '    "sha256_cert_fingerprints": ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3308.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'invalid package name'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3309: Android app asset descriptors must have at least one certificate'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3309.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest3309", '
          '    "sha256_cert_fingerprints": []},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3309.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'must contain at least one certificate'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3310: Certificate in Android app asset descriptors must be non-empty'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3310.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest3310", '
          '    "sha256_cert_fingerprints": [""]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3310.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'malformed cert'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3311: Certificate in Android app asset descriptors must be well-formed (1)'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3311.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest3311", '
          '    "sha256_cert_fingerprints": ["B A D"]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3311.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'malformed cert'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3312: Certificate in Android app asset descriptors must be well-formed (2)'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3312.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest3312", '
          '    "sha256_cert_fingerprints": ["14:6d:e9:83:c5:73:06:50:d8:ee:b9:95:2f:34:fc:64:16:a0:83:42:e6:1d:be:a8:8a:04:96:b2:3f:cf:44:e5"]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3312.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'malformed cert'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3313: Certificate in Android app asset descriptors must be well-formed (3)'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3313.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest3313", '
          # First octets are out of range.
          '    "sha256_cert_fingerprints": ["GG:HH:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3313.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'malformed cert'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3314: Certificate in Android app asset descriptors must be well-formed (4)'
  stub_environment_only: true  # The API parses APK statements offline.
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3314.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest3314", '
          # One octet missing.
          '    "sha256_cert_fingerprints": ["6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3314.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'malformed cert'
    error_code: [ ERROR_CODE_MALFORMED_CONTENT ]
  }
}

test_group: {
  name: 'comptest3315: statement list with a valid statement (app-to-app statement)'
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3315.source'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest3315.target", '
          '    "sha256_cert_fingerprints": ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3315.source'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3315.target'
        certificate {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'comptest3316: statement list with a valid statement (statement with identical source and target)'
  android_content: {
    package_name: 'org.digitalassetlinks.comptest3316'
    cert_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
    assets_statements: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest3316", '
          '    "sha256_cert_fingerprints": ["BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3"]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3316'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest3316'
        certificate {
          sha256_fingerprint: 'BB:DE:FA:29:50:F4:98:82:F2:95:B1:28:5D:4F:A9:DE:C4:5F:C4:14:4B:FB:07:EE:6A:CC:68:76:2D:12:C2:E3'
        }
      } }
    }
    outcome: SUCCESS
    response: true
  }
}
