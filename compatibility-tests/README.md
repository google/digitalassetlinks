# Digital Asset Links Compatibility Tests

The tests defined in this directory can be used to ensure that implementations
of the Digital Asset Links protocol remain compatible with each other.

## Running tests in production

By default, all test cases are hermetic: all relevant state is contained in the
`TestGroup` message.

To facilitate testing of implementations in production, some of the test data is
also served on the public internet:

* All `web_content` targets contained in this test suite are served publicly,
  unless the field `stub_environment_only` is set in the enclosing `TestGroup`
  message.  Example:
  `https://source-smoketests01.digitalassetlinks.org/.well-known/assetlinks.json`

* All `android_content` targets contained in this test suite are available via
  Google's [Digital Asset Links
  API](https://developers.google.com/digital-asset-links/), unless the field
  `stub_environment_only` is set in the enclosing `TestGroup` message.
  Example:
  `https://digitalassetlinks.googleapis.com/v1/statements:list?source.android_app.package_name=org.digitalassetlinks.smoketests02.source&source.android_app.certificate.sha256_fingerprint=14%3A6D%3AE9%3A83%3AC5%3A73%3A06%3A50%3AD8%3AEE%3AB9%3A95%3A2F%3A34%3AFC%3A64%3A16%3AA0%3A83%3A42%3AE6%3A1D%3ABE%3AA8%3A8A%3A04%3A96%3AB2%3A3F%3ACF%3A44%3AE5&relation=delegate_permission/common.handle_all_urls`
