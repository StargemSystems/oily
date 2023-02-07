# Faux Bash

OSH will error out when given most flags meant for Bash. This script is a wrapper that will strip offending flags and pass the remaining to OSH. To allow running as an interpreter, it is compiled using `shc`.
