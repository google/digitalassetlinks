# All the test cases in this group cover parsing of statement lists on web
# assets (i.e., inside of .well-known/assetlinks.json files).  Specifically, this
# file contains tests specific to parsing of Android app assets in the target
# field.

test_group: {
  name: 'comptest2301: statement list with a valid statement (target is an Android app)'
  web_content: {
    url: 'https://comptest2301.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest2301", "sha256_cert_fingerprints": ["00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00"]}, "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2301.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest2301'
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
  name: 'comptest2302: statement list with a valid statement (target is an Android app with two certificates)'
  web_content: {
    url: 'https://comptest2302.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest2302", "sha256_cert_fingerprints": ["11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11:11", "22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22:22"]}, "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2302.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest2302'
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
      source: { web: { site: 'https://comptest2302.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest2302'
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
  name: 'comptest2303: Android app asset descriptors must have a package name'
  web_content: {
    url: 'https://comptest2303.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "android_app", "sha256_cert_fingerprints": ["00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00"]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2303.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'no package_name field'
  }
}

test_group: {
  name: 'comptest2304: Android app asset descriptors must have a certificate fingerprint'
  web_content: {
    url: 'https://comptest2304.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest2304"},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2304.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'sha256_cert_fingerprints'
  }
}

test_group: {
  name: 'comptest2305: Certificate fingerprints in Android app asset descriptors must be given as an array'
  web_content: {
    url: 'https://comptest2305.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest2305", '
          '    "sha256_cert_fingerprints": "00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00"},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2305.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'not an array'
  }
}

test_group: {
  name: 'comptest2306: Individual certificate fingerprints in Android app asset descriptors must be strings'
  web_content: {
    url: 'https://comptest2306.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest2306", '
          '    "sha256_cert_fingerprints": [{}] },'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2306.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'sha256_cert_fingerprints'
  }
}

test_group: {
  name: 'comptest2307: Android app asset descriptors must have a non-empty package name'
  web_content: {
    url: 'https://comptest2307.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "android_app", "package_name": "", '
          '    "sha256_cert_fingerprints": ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2307.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'invalid package name'
  }
}

test_group: {
  name: 'comptest2308: Android app asset descriptors must have a valid package name'
  web_content: {
    url: 'https://comptest2308.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "android_app", "package_name": "B A D", '
          '    "sha256_cert_fingerprints": ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2308.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'invalid package name'
  }
}

test_group: {
  name: 'comptest2309: Android app asset descriptors must have at least one certificate'
  web_content: {
    url: 'https://comptest2309.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest2309", '
          '    "sha256_cert_fingerprints": []},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2309.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'must contain at least one certificate'
  }
}

test_group: {
  name: 'comptest2310: Certificate in Android app asset descriptors must be non-empty'
  web_content: {
    url: 'https://comptest2310.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest2310", '
          '    "sha256_cert_fingerprints": [""]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2310.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'malformed cert'
  }
}

test_group: {
  name: 'comptest2311: Certificate in Android app asset descriptors must be well-formed (1)'
  web_content: {
    url: 'https://comptest2311.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest2311", '
          '    "sha256_cert_fingerprints": ["B A D"]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2311.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'malformed cert'
  }
}

test_group: {
  name: 'comptest2312: Certificate in Android app asset descriptors must be well-formed (2)'
  web_content: {
    url: 'https://comptest2312.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest2312", '
          '    "sha256_cert_fingerprints": ["14:6d:e9:83:c5:73:06:50:d8:ee:b9:95:2f:34:fc:64:16:a0:83:42:e6:1d:be:a8:8a:04:96:b2:3f:cf:44:e5"]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2312.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'malformed cert'
  }
}

test_group: {
  name: 'comptest2313: Certificate in Android app asset descriptors must be well-formed (3)'
  web_content: {
    url: 'https://comptest2313.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest2313", '
          # First octets are out of range.
          '    "sha256_cert_fingerprints": ["GG:HH:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2313.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'malformed cert'
  }
}

test_group: {
  name: 'comptest2314: Certificate in Android app asset descriptors must be well-formed (4)'
  web_content: {
    url: 'https://comptest2314.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "android_app", "package_name": "org.digitalassetlinks.comptest2314", '
          # One octet missing.
          '    "sha256_cert_fingerprints": ["6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"]},'
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2314.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'malformed cert'
  }
}

