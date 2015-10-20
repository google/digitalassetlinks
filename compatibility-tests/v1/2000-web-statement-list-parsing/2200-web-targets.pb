# All the test cases in this group cover parsing of statement lists on web
# assets (i.e., inside of .well-known/assetlinks.json files).  Specifically, this
# file contains tests specific to parsing of web assets in the target field.

test_group: {
  name: 'comptest2201: statement list with a valid statement (typical case)'
  web_content: {
    url: 'https://comptest2201.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "web", "site": "https://target.digitalassetlinks.org"}, '
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2201.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { web: { site: 'https://target.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'comptest2202: statement list with a valid statement (statement with identical source and target)'
  web_content: {
    url: 'https://comptest2202.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "web", "site": "https://comptest2202.digitalassetlinks.org"}, '
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2202.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { web: { site: 'https://comptest2202.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'comptest2203: statement list with a valid statement (source uses a non-standard port number)'
  stub_environment_only: true  # Non-standard HTTP port used.
  web_content: {
    url: 'http://comptest2203.digitalassetlinks.org:8080/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "web", "site": "https://comptest2203.digitalassetlinks.org"}, '
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'http://comptest2203.digitalassetlinks.org:8080' } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { web: { site: 'https://comptest2203.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'comptest2204: statement list with a valid statement (fully qualified target)'
  web_content: {
    url: 'https://comptest2204.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "web", "site": "https://target.digitalassetlinks.org."}, '
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2204.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { web: { site: 'https://target.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'comptest2205: statement list with a valid statement (Mixed-case URL)'
  web_content: {
    url: 'https://comptest2205.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"target": {"namespace": "web", "site": "HtTpS://target.digitalassetlinks.org"}, '
          '  "relation": ["delegate_permission/common.get_login_creds"]}]'
  }

  check_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2205.digitalassetlinks.org' } }
      relation: 'delegate_permission/common.get_login_creds'
      target: { web: { site: 'https://target.digitalassetlinks.org' } }
    }
    outcome: SUCCESS
    response: true
  }
}

test_group: {
  name: 'comptest2206: web asset descriptors must have a URL'
  web_content: {
    url: 'https://comptest2206.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web" } }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2206.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'no site field'
  }
}

test_group: {
  name: 'comptest2207: web asset descriptors must contain valid URLs (the port number is invalid)'
  web_content: {
    url: 'https://comptest2207.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://target.digitalassetlinks.org:999999"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2207.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'not a valid URL'
  }
}

test_group: {
  name: 'comptest2208: web asset descriptors must contain HTTP or HTTPS URLs'
  web_content: {
    url: 'https://comptest2208.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "mailto://user@digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2208.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'non-HTTP URL'
  }
}

test_group: {
  name: 'comptest2209: web asset descriptors must contain URLs without login info'
  web_content: {
    url: 'https://comptest2209.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://x:y@target.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2209.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'login information'
  }
}

test_group: {
  name: 'comptest2210: web asset descriptors must contain URLs without query parameters'
  web_content: {
    url: 'https://comptest2210.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://target.digitalassetlinks.org?bar"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2210.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'query parameters'
  }
}

test_group: {
  name: 'comptest2211: web asset descriptors must contain URLs without fragment IDs'
  web_content: {
    url: 'https://comptest2211.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://target.digitalassetlinks.org#bar"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2211.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'fragment identifiers'
  }
}

test_group: {
  name: 'comptest2212: web asset descriptors must contain URLs without path components (1)'
  web_content: {
    url: 'https://comptest2212.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://target.digitalassetlinks.org/"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2212.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'cannot contain a path'
  }
}

test_group: {
  name: 'comptest2213: web asset descriptors must contain URLs without path components (2)'
  web_content: {
    url: 'https://comptest2213.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://target.digitalassetlinks.org/XXX"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2213.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'cannot contain a path'
  }
}

test_group: {
  name: 'comptest2214: web asset descriptors must contain URLs without path components (3)'
  web_content: {
    url: 'https://comptest2214.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://target.digitalassetlinks.org/XXX/"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2214.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'cannot contain a path'
  }
}

test_group: {
  name: 'comptest2215: web asset descriptors must contain URLs without path components (4)'
  web_content: {
    url: 'https://comptest2215.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "https://target.digitalassetlinks.org/*"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2215.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: 'cannot contain a path'
  }
}

test_group: {
  name: 'comptest2216: web asset descriptors must contain a scheme'
  web_content: {
    url: 'https://comptest2216.digitalassetlinks.org/.well-known/assetlinks.json'
    body: '[{"relation": ["delegate_permission/common.handle_all_urls"], '
          '  "target" : { "namespace": "web", "site": "target.digitalassetlinks.org"} }]'
  }

  list_statements_tests: {
    name: 'Parses assetlinks.json correctly.'
    request: {
      source: { web: { site: 'https://comptest2216.digitalassetlinks.org' } }
    }
    outcome: FETCH_ERROR
    error_message_regex: '(Invalid site|Url is not well formatted)'
  }
}
