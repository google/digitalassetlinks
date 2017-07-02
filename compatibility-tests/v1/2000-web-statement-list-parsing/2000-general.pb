# All the test cases in this group cover parsing of statement lists on web
# assets (i.e., inside of .well-known/assetlinks.json files).  Specifically, this
# file contains tests that are not specific to a particular target asset type,
# and not specific to parsing of the relation string.

test_group: {
  name: 'comptest2001: statement list with valid statements (multiple statements and multiple relations)'
  web_content: {
    url: 'https://source-comptest2001.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls", "delegate_permission/common.get_user_location"],'
          '  "target" : { "namespace": "android_app", "package_name": "org.digitalassetlinks.comptest2001", "sha256_cert_fingerprints": ["14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"] }},'
          ' {"relation": [ "delegate_permission/common.get_login_creds" ],'
          '  "target" : { "namespace": "web", "site": "https://target-comptest2001.digitalassetlinks.org" }}] '
  }

  check_statements_tests: {
    name: 'Finds first relation.'
    request: {
      source: { web: { site: 'https://source-comptest2001.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest2001'
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
      source: { web: { site: 'https://source-comptest2001.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.get_user_location'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest2001'
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
      source: { web: { site: 'https://source-comptest2001.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { web: { site: 'https://target-comptest2001.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'comptest2002: empty statement list'
  web_content: {
    url: 'https://source-comptest2002.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2002.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'No statements were found'
    # No response field because we expect the list to be empty.
  }
}

test_group: {
  name: 'comptest2003: single invalid statement in statements list is skipped'
  web_content: {
    url: 'https://source-comptest2003.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "web", "site": "https://target-comptest2003.digitalassetlinks.org"}, '
          '  "relation": ["delegate_permission/common.get_login_creds"]},     '
          ' {},                                                               '
          '{"relation": ["delegate_permission/common.handle_all_urls"],       '
          ' "target": {"namespace": "android_app",                            '
          '            "package_name": "org.digitalassetlinks.comptest2003",  '
          '            "sha256_cert_fingerprints":                            '
          '             ["10:39:38:EE:45:37:E5:9E:8E:E7:92:F6:54:50:4F:B8:'
                         '34:6F:C6:B3:46:D0:BB:C4:41:5F:C3:39:FC:FC:8E:C1"]}}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2003.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { web: { site: 'https://target-comptest2003.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Could not parse (manifest|statement list)'
    response: true
  }

  check_statements_tests: {
    name: 'Test: Valid statement in the statement list should not be ignored.'
    request: {
      source: { web: { site: 'https://source-comptest2003.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.handle_all_urls'
      target: { android_app: {
        package_name: 'org.digitalassetlinks.comptest2003'
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
  name: 'comptest2004: include directives do not allow other standard fields'
  web_content: {
    url: 'https://source-comptest2004.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "web", "site": "https://target-comptest2004.digitalassetlinks.org"}, '
          '  "include": "https://source-comptest2004.digitalassetlinks.org/includefile.json" }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2004.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'invalid field'
    # No response field because we expect the list to be empty.
  }
}

test_group: {
  name: 'comptest2005: include directives *do* allow other non-standard fields (for extensibility)'
  web_content: {
    url: 'https://source-comptest2005.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"magicfield": {"foo": "bar"}, '
          '  "include": "https://source-comptest2005.digitalassetlinks.org/includefile.json" }]'
  }

  web_content: {
    url: 'https://source-comptest2005.digitalassetlinks.org/includefile.json'
    body: '[{"target": {"namespace": "web", "site": "https://target-comptest2005.digitalassetlinks.org"}, '
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2005.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { web: { site: 'https://target-comptest2005.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'comptest2006: statement list parsing fails when JSON is invalid (1)'
  web_content: {
    url: 'https://source-comptest2006.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2006.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'not valid JSON'
  }
}

test_group: {
  name: 'comptest2007: statement list parsing uses strict JSON parsing mode (security requirement) (1)'
  web_content: {
    url: 'https://source-comptest2007.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '42'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2007.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'not valid JSON'
  }
}

test_group: {
  name: 'comptest2008: statement list parsing uses strict JSON parsing mode (security requirement) (2)'
  web_content: {
    url: 'https://source-comptest2008.digitalassetlinks.org/.well-known/assetlinks.json'
    # The comma in the relation array below implies a "dropped null
    # placeholder", which is not allowed in strict mode.
    body: '[{"relation": [ "delegate_permission/common.handle_all_urls", ], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2008.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2008.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'not valid JSON'
  }
}

test_group: {
  name: 'comptest2009: statement list must be encoded as a single JSON array'
  web_content: {
    url: 'https://source-comptest2009.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '{"relation": [ "delegate_permission/common.handle_all_urls" ], '
          '  "target" : { "namespace": "web", "site": "https://target-comptest2009.digitalassetlinks.org"} }'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2009.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'expected a single array'
  }
}

test_group: {
  name: 'comptest2010: statement list must be encoded as a JSON object'
  web_content: {
    url: 'https://source-comptest2010.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '"foo"'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2010.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'Could not parse (manifest|statement list)'
  }
}

test_group: {
  name: 'comptest2011: statement list must have a target'
  web_content: {
    url: 'https://source-comptest2011.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": [ "delegate_permission/common.handle_all_urls" ]}]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2011.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'no target specified'
  }
}

test_group: {
  name: 'comptest2012: statement list must have a relation'
  web_content: {
    url: 'https://source-comptest2012.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{ "target" : { "namespace": "web", "site": "https://target-comptest2012.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2012.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'no relation'
  }
}

test_group: {
  name: 'comptest2013: asset descriptors must be objects'
  web_content: {
    url: 'https://source-comptest2013.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : "https://target-comptest2013.digitalassetlinks.org" }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2013.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'not an object'
  }
}

test_group: {
  name: 'comptest2014: asset descriptors must use a recognized namespace'
  web_content: {
    url: 'https://source-comptest2014.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "internets", "site": "https://target-comptest2014.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://source-comptest2014.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'unrecognized namespace'
  }
}
