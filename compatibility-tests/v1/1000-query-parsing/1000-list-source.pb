# All the test cases in this group cover parsing of asset queries in the
# 'source' field of List() requests.  Note that parsing errors should cause the
# API to abort the request immediately.

test_group: {
  name: 'comptest1001: source queries in List requests'

  web_content: {
    url: 'https://secure-comptest1001.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[]'
  }

  web_content: {
    url: 'http://insecure-comptest1001.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[]'
  }

  android_content: {
    package_name: 'org.digtitalassetlinks.comptest1001'
    cert_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
    assets_statements: '[]'
  }

  # First a few valid queries.
  list_statements_tests: {
    name: 'Typical list request with a web asset query (1)'
    request: {
      source: { web: { site: 'https://secure-comptest1001.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
  }

  list_statements_tests: {
    name: 'Typical list request with a web asset query (2)'
    request: {
      source: { web: { site: 'http://insecure-comptest1001.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
  }

  list_statements_tests: {
    name: 'Typical list request with a web asset query (3)'
    request: {
      source: { web: { site: 'http://insecure-comptest1001.digitalassetlinks.org:80' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
  }

  list_statements_tests: {
    name: 'Typical list request with a web asset query (4)'
    request: {
      source: { web: { site: 'https://secure-comptest1001.digitalassetlinks.org:443' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
  }

  list_statements_tests: {
    name: 'Typical list request with a web asset query (5)'
    request: {
      source: { web: { site: 'HTTPS://secure-comptest1001.DIGITALASSETLINKS.ORG' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
  }

  list_statements_tests: {
    name: 'Typical list request with an Android asset query'
    request: {
      source: { android_app: {
        package_name: 'org.digtitalassetlinks.comptest1001'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
  }

  # Now some invalid queries.
  list_statements_tests: {
    name: 'Missing asset query'
    request: {
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Request must contain a source asset query'
  }

  list_statements_tests: {
    name: 'Missing asset query specialization'
    request: {
      source: { }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Must specify one of the asset types'
  }

  # Invalid web asset queries.
  list_statements_tests: {
    name: 'Missing "site" field in Web asset query'
    request: {
      source: { web: { } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'No site field'
  }

  list_statements_tests: {
    name: 'Empty "site" field in Web asset query'
    request: {
      source: { web: { site: '' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'No site field'
  }

  list_statements_tests: {
    name: 'Invalid URL in "site" field in Web asset query (the port number is invalid)'
    request: {
      source: { web: { site: 'https://secure-comptest1001.digitalassetlinks.org:99999' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid site'
  }

  list_statements_tests: {
    name: 'Non-empty path in "site" field in Web asset query (1)'
    request: {
      source: { web: { site: 'https://secure-comptest1001.digitalassetlinks.org/foo' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid site'
  }

  list_statements_tests: {
    name: 'Non-empty path in "site" field in Web asset query (2)'
    request: {
      source: { web: { site: 'https://secure-comptest1001.digitalassetlinks.org/' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid site'
  }

  list_statements_tests: {
    name: 'Non-empty query string in "site" field in Web asset query'
    request: {
      source: { web: { site: 'https://secure-comptest1001.digitalassetlinks.org?foo' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid site'
  }

  list_statements_tests: {
    name: 'Non-empty fragment ID in "site" field in Web asset query'
    request: {
      source: { web: { site: 'https://secure-comptest1001.digitalassetlinks.org#foo' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid site'
  }

  # Invalid Android asset queries.
  list_statements_tests: {
    name: 'Missing "package_name" field Android asset query'
    request: {
      source: { android_app: {
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'No package_name field'
  }

  list_statements_tests: {
    name: 'Empty "package_name" field Android asset query'
    request: {
      source: { android_app: {
        package_name: ''
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'No package_name field'
  }

  list_statements_tests: {
    name: 'Missing "certificate" field Android asset query'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest1001'
      } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid sha256_fingerprint field'
  }

  list_statements_tests: {
    name: 'Empty "certificate" field Android asset query'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest1001'
        certificate: {
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid sha256_fingerprint field'
  }

  list_statements_tests: {
    name: 'Empty "sha256_fingerprint" field Android asset query'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest1001'
        certificate: {
          sha256_fingerprint: ''
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid sha256_fingerprint field'
  }

  list_statements_tests: {
    name: 'Lowercase characters in "sha256_fingerprint" field Android asset query'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest1001'
        certificate: {
          sha256_fingerprint: '14:6d:e9:83:c5:73:06:50:d8:ee:b9:95:2f:34:fc:64:16:a0:83:42:e6:1d:be:a8:8a:04:96:b2:3f:cf:44:e5'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid sha256_fingerprint field'
  }

  list_statements_tests: {
    name: 'Leading whitespace in "sha256_fingerprint" field Android asset query'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest1001'
        certificate: {
          sha256_fingerprint: ' 14:6d:e9:83:c5:73:06:50:d8:ee:b9:95:2f:34:fc:64:16:a0:83:42:e6:1d:be:a8:8a:04:96:b2:3f:cf:44:e5'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid sha256_fingerprint field'
  }

  list_statements_tests: {
    name: 'Trailing whitespace in "sha256_fingerprint" field Android asset query'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest1001'
        certificate: {
          sha256_fingerprint: '14:6d:e9:83:c5:73:06:50:d8:ee:b9:95:2f:34:fc:64:16:a0:83:42:e6:1d:be:a8:8a:04:96:b2:3f:cf:44:e5 '
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid sha256_fingerprint field'
  }

  list_statements_tests: {
    name: 'Missing colons in "sha256_fingerprint" field Android asset query'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest1001'
        certificate: {
          sha256_fingerprint: '146DE983C5730650D8EEB9952F34FC6416A08342E61DBEA88A0496B23FCF44E5'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid sha256_fingerprint field'
  }

  list_statements_tests: {
    name: 'Too few octets in "sha256_fingerprint" field Android asset query'
    request: {
      source: { android_app: {
        package_name: 'org.digitalassetlinks.comptest1001'
        certificate: {
          sha256_fingerprint: '14:6D:E9:83:C5:73'
        }
      } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: QUERY_PARSING_ERROR
    error_message_regex: 'Invalid sha256_fingerprint field'
  }
}

test_group: {
  name: 'comptest1002: source queries in List requests (non-standard ports)'
  stub_environment_only: true  # Non-standard HTTP port used.

  web_content: {
    url: 'http://insecure-comptest1002.digitalassetlinks.org:88/.well-known/assetlinks.json'
    body: '[]'
  }

  web_content: {
    url: 'https://secure-comptest1002.digitalassetlinks.org:444/.well-known/assetlinks.json'
    body: '[]'
  }

  list_statements_tests: {
    name: 'Typical list request with a web asset query (1)'
    request: {
      source: { web: { site: 'http://insecure-comptest1002.digitalassetlinks.org:88' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
  }

  list_statements_tests: {
    name: 'Typical list request with a web asset query (2)'
    request: {
      source: { web: { site: 'https://secure-comptest1002.digitalassetlinks.org:444' } }
      relation: 'delegate_permission/common.handle_all_urls'
    }
    outcome: SUCCESS
  }
}
