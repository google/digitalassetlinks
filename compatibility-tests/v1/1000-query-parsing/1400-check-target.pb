# All the test cases in this group cover parsing of asset queries in the
# 'target' field of Check() requests.  Note that parsing errors should cause the
# API to abort the request immediately.

test_group: {
  name: 'comptest1401: target queries in Check requests'

  web_content: {
    url: 'https://source-comptest1401.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[]'
  }

  # First a few valid queries.
  check_statements_tests: {
    name: 'Typical list request with a web asset query (1)'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-comptest1401.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
  }

  check_statements_tests: {
    name: 'Typical list request with a web asset query (2)'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'http://target-comptest1401.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
  }

  check_statements_tests: {
    name: 'Typical list request with a web asset query (3)'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'http://target-comptest1401.digitalassetlinks.org:80' } }
    }
    outcome: SUCCESS
  }

  check_statements_tests: {
    name: 'Typical list request with a web asset query (4)'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'http://target-comptest1401.digitalassetlinks.org:88' } }
    }
    outcome: SUCCESS
  }

  check_statements_tests: {
    name: 'Typical list request with a web asset query (5)'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-comptest1401.digitalassetlinks.org:444' } }
    }
    outcome: SUCCESS
  }

  check_statements_tests: {
    name: 'Typical list request with a web asset query (6)'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://target-comptest1401.digitalassetlinks.org:443' } }
    }
    outcome: SUCCESS
  }

  check_statements_tests: {
    name: 'Typical list request with a web asset query (7)'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'HTTPS://target-comptest1401.DIGITALASSETLINKS.ORG' } }
    }
    outcome: SUCCESS
  }

  check_statements_tests: {
    name: 'Typical list request with an Android asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digtitalassetlinks.comptest1401'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
    }
    outcome: SUCCESS
  }

  # Now some invalid queries.
  check_statements_tests: {
    name: 'Missing asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Request must contain a target asset query'
  }

  check_statements_tests: {
    name: 'Missing asset query specialization'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Must specify one of the asset types'
  }

  # Invalid web asset queries.
  check_statements_tests: {
    name: 'Missing "site" field in Web asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'No site field'
  }

  check_statements_tests: {
    name: 'Empty "site" field in Web asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: '' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'No site field'
  }

  check_statements_tests: {
    name: 'Invalid URL in "site" field in Web asset query (the port number is invalid)'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://comptest1401.digitalassetlinks.org:99999' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid site'
  }

  check_statements_tests: {
    name: 'Non-empty path in "site" field in Web asset query (1)'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://comptest1401.digitalassetlinks.org/foo' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid site'
  }

  check_statements_tests: {
    name: 'Non-empty path in "site" field in Web asset query (2)'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://comptest1401.digitalassetlinks.org/' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid site'
  }

  check_statements_tests: {
    name: 'Non-empty query string in "site" field in Web asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://comptest1401.digitalassetlinks.org?foo' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid site'
  }

  check_statements_tests: {
    name: 'Non-empty fragment ID in "site" field in Web asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { web: { site: 'https://comptest1401.digitalassetlinks.org#foo' } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid site'
  }

  # Invalid Android asset queries.
  check_statements_tests: {
    name: 'Missing "package_name" field Android asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid package_name field'
  }

  check_statements_tests: {
    name: 'Empty "package_name" field Android asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: ''
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid package_name field'
  }

  check_statements_tests: {
    name: 'Leading whitespace in "package_name" field Android asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: ' foo'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid package_name field'
  }

  check_statements_tests: {
    name: 'Trailing whitespace in "package_name" field Android asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'foo '
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid package_name field'
  }

  check_statements_tests: {
    name: 'Missing "certificate" field Android asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest1401'
      } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid sha256_fingerprint field'
  }

  check_statements_tests: {
    name: 'Empty "certificate" field Android asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest1401'
        certificate: {
        }
      } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid sha256_fingerprint field'
  }

  check_statements_tests: {
    name: 'Empty "sha256_fingerprint" field Android asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest1401'
        certificate: {
          sha256_fingerprint: ''
        }
      } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid sha256_fingerprint field'
  }

  check_statements_tests: {
    name: 'Lowercase characters in "sha256_fingerprint" field Android asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest1401'
        certificate: {
          sha256_fingerprint: '14:6d:e9:83:c5:73:06:50:d8:ee:b9:95:2f:34:fc:64:16:a0:83:42:e6:1d:be:a8:8a:04:96:b2:3f:cf:44:e5'
        }
      } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid sha256_fingerprint field'
  }

  check_statements_tests: {
    name: 'Leading whitespace in "sha256_fingerprint" field Android asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest1401'
        certificate: {
          sha256_fingerprint: ' 14:6d:e9:83:c5:73:06:50:d8:ee:b9:95:2f:34:fc:64:16:a0:83:42:e6:1d:be:a8:8a:04:96:b2:3f:cf:44:e5'
        }
      } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid sha256_fingerprint field'
  }

  check_statements_tests: {
    name: 'Trailing whitespace in "sha256_fingerprint" field Android asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest1401'
        certificate: {
          sha256_fingerprint: '14:6d:e9:83:c5:73:06:50:d8:ee:b9:95:2f:34:fc:64:16:a0:83:42:e6:1d:be:a8:8a:04:96:b2:3f:cf:44:e5 '
        }
      } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid sha256_fingerprint field'
  }

  check_statements_tests: {
    name: 'Missing colons in "sha256_fingerprint" field Android asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest1401'
        certificate: {
          sha256_fingerprint: '146DE983C5730650D8EEB9952F34FC6416A08342E61DBEA88A0496B23FCF44E5'
        }
      } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid sha256_fingerprint field'
  }

  check_statements_tests: {
    name: 'Too few octets in "sha256_fingerprint" field Android asset query'
    request: {
      source: { web: { site: 'https://source-comptest1401.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest1401'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73'
        }
      } }
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid sha256_fingerprint field'
  }
}
