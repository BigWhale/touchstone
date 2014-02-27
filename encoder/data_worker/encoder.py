#===============================================================================
#-------------------------------------------------------------------------------
from utils import Utils
import sys
import env_settings
#-------------------------------------------------------------------------------
def encode():
    u = Utils()
    server = env_settings.GEARMAN_SERVER + ":4730"
    GM_SERVERS = [server]
    print GM_SERVERS
    print "Starting encoding"
    
    u.register_job(GM_SERVERS, "encode", u.encode_job)
#-------------------------------------------------------------------------------
def main():
    encode()
#-------------------------------------------------------------------------------
if __name__ == "__main__":
    main()
#===============================================================================
