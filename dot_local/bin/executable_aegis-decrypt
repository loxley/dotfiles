#!/usr/bin/env python3

# this depends on the 'cryptography', 'pyotp' and 'qrcode' packages
# pip install cryptography pyotp qrcode

# example usage: ./scripts/decrypt.py --input ./app/src/test/resources/com/beemdevelopment/aegis/importers/aegis_encrypted.json
# password: test

import argparse
import base64
import getpass
import io
import json
from os import system
import signal
import sys
from time import localtime, sleep

import cryptography
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives.ciphers.aead import AESGCM
from cryptography.hazmat.primitives.kdf.scrypt import Scrypt
import pyotp
import qrcode

backend = default_backend()


def die(msg, code=1):
    print(msg, file=sys.stderr)
    exit(code)


def signal_handler(signal, frame):
    system("clear")
    sys.exit(0)


def main():
    parser = argparse.ArgumentParser(
        description="Decrypt an Aegis vault and continuously show TOTP or generate otpauth/QR codes for import"
    )
    parser.add_argument(
        "--input", dest="input", required=True, help="encrypted Aegis vault file"
    )
    parser.add_argument("--output", dest="output", help="output file ('-' for stdout)")
    parser.add_argument(
        "--otpauth",
        dest="otpauth",
        action="store_true",
        help="return provisioning uri (otpauth://)",
    )
    parser.add_argument(
        "--qrcode", dest="qr_code", action="store_true", help="generate qrcode"
    )
    parser.set_defaults(otpauth=False, qrcode=False)
    args = parser.parse_args()

    # parse the Aegis vault file
    with io.open(args.input, "r") as f:
        data = json.load(f)

    # listen to ctrl+c
    signal.signal(signal.SIGINT, signal_handler)

    # ask the user for a password
    password = getpass.getpass().encode("utf-8")

    # extract all password slots from the header
    header = data["header"]
    slots = [slot for slot in header["slots"] if slot["type"] == 1]

    # try the given password on every slot until one succeeds
    master_key = None
    for slot in slots:
        # derive a key from the given password
        kdf = Scrypt(
            salt=bytes.fromhex(slot["salt"]),
            length=32,
            n=slot["n"],
            r=slot["r"],
            p=slot["p"],
            backend=backend,
        )
        key = kdf.derive(password)

        # try to use the derived key to decrypt the master key
        cipher = AESGCM(key)
        params = slot["key_params"]
        try:
            master_key = cipher.decrypt(
                nonce=bytes.fromhex(params["nonce"]),
                data=bytes.fromhex(slot["key"]) + bytes.fromhex(params["tag"]),
                associated_data=None,
            )
            break
        except cryptography.exceptions.InvalidTag:
            pass

    if master_key is None:
        die("error: unable to decrypt the master key with the given password")

    # decode the base64 vault contents
    content = base64.b64decode(data["db"])

    # decrypt the vault contents using the master key
    params = header["params"]
    cipher = AESGCM(master_key)
    db = cipher.decrypt(
        nonce=bytes.fromhex(params["nonce"]),
        data=content + bytes.fromhex(params["tag"]),
        associated_data=None,
    )

    db = db.decode("utf-8")
    if args.output:
        if args.output != "-":
            with io.open(args.output, "w") as f:
                f.write(db)
        else:
            print(db)
    else:
        decrypted = json.loads(db)
        while True:
            count = True
            system("clear")
            if args.otpauth:
                print(f"{'Issuer' : <40} TOTP")
            else:
                print(f"{'Issuer' : <40} {'TOTP' : <6} Name")
            for entry in sorted(decrypted["entries"], key=lambda i: (i["issuer"])):
                if args.otpauth:
                    gen = pyotp.totp.TOTP(entry["info"]["secret"]).provisioning_uri(
                        name=entry["name"], issuer_name=entry["issuer"]
                    )
                    print(f"{entry['issuer'][0:40] : <40} {gen}")
                    if args.qr_code:
                        qr = qrcode.QRCode(version=1)
                        qr.add_data(gen)
                        qr.make()
                        qr.print_ascii(tty=True)
                else:
                    totp = pyotp.TOTP(entry["info"]["secret"])
                    print(
                        f"{entry['issuer'][0:40] : <40} {totp.now()} ({entry['name']})"
                    )
            if args.otpauth:
                break
            # Countdown until next TOTP
            while count:
                diff = 0
                local_time = localtime()
                tmsec = local_time.tm_sec
                if tmsec >= 30:
                    diff = 60 - tmsec
                    if diff == 1:
                        count = False
                elif tmsec < 30:
                    diff = 30 - tmsec
                    if diff == 1:
                        count = False
                print(f"Countdown: {diff : <2}", end="\r")
                sleep(1)


if __name__ == "__main__":
    main()
