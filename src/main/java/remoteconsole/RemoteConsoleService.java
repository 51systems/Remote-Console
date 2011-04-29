package remoteconsole;

import org.cometd.bayeux.Message;
import org.cometd.bayeux.server.BayeuxServer;
import org.cometd.bayeux.server.ServerSession;
import org.cometd.server.AbstractService;


public class RemoteConsoleService extends AbstractService
{
    public RemoteConsoleService(BayeuxServer bayeux)
    {
        super(bayeux, "remote-console");
        addService("/remote-console/*", "processRemoteConsole");
    }
    
    public void processRemoteConsole(ServerSession remote, String channelName, Message message, String messageId)
    {
    	getBayeux().getChannel(channelName).publish(getServerSession(), message, null);
    }
}
