# Certificate + Private Key Combiner

A bash script to check if and merge a certificate and private key file into 1 file, for systems that need both together.

## Usage
Make sure the `combineCertAndKey.sh` file is executable, `chmod +x combineCertAndKey.sh`.

Once that's done, can run it, `./combineCertAndKey.sh`, passing in the required/optional arguments

Once finished, the provided certificate file will contain the resulting merged data

### Arguments
`-c` Path to the certificate file to use (required)

`-k` Path to the key file to use (required)

`-s` Service to try and reload once merge is complete (optional)

### Example
To merge the cert file `cert.crt` and private key `test.key`, and to reload HAProxy
once the merge is successful, you can run this as:
```bash 
./combineCertAndKey.sh -c cert.crt -k test.key -s haproxy
```