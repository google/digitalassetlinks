# The "assetlinks.json" Well-Known Resource Identifier

This document describes the use of URIs whose path component is
`/.well-known/assetlinks.json`.

## Purpose
A URI with the path component `/.well-known/assetlinks.json` is used by the
AssetLinks protocol to identify one or more digital assets (such as web sites
or mobile apps) that are related to the hosting web site in some fashion.

## Details
Please refer to the [Asset Links specification](details.md) for details,
specifically the section "Determining the Set of Reliable Statements".

Example:

```json
[
  {
    "namespace": "android_app",
    "package_name": "org.digitalassetlinks.example",
    "sha256_cert_fingerprints":
    [
      "14:6D:E9:83:C5:73:06:50:D8:EE:B9:95:2F:34:FC:64:16:",
      "A0:83:42:E6:1D:BE:A8:8A:04:96:B2:3F:CF:44:E5"
    ]
  }
]
```
