using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;

namespace TAMSR2
{
    public class TAMSR2Hub : Hub
    {
        public void Send(string name, string message)
        {
            // Call the broadcastMessage method to update clients.
            Clients.All.broadcastMessage(name, message);
        }

        public void TAMSR2Users(string name)
        {
            // Call the broadcastMessage method to update clients.
            Clients.All.broadcastMessage(name);
        }
    }
}