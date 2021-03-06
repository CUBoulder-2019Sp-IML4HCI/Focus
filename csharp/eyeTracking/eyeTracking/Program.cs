﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Tobii.Interaction;
using System.Runtime.InteropServices;


namespace eyeTracking
{
    class Program
    {
        static void Main(string[] args)
        {
            double average;
            double sumOfSquaresOfDifferences;
            double sdx;
            double sdy;
            float two = 2;
            double[] last10x = new double[10];
            double[] last10y = new double[10];
            float[] last10sdx = new float[10];
            float[] last10sdy = new float[10];
            float lastx = 200;
            float lasty = 200;
            var sender = new SharpOSC.UDPSender("127.0.0.1", 6448);
            var sender2 = new SharpOSC.UDPSender("127.0.0.1", 6449);
            var sender3 = new SharpOSC.UDPSender("127.0.0.1", 12003);
            int numSet = 0;
            int clickCounter = 0;
            int noClick = 0;
            var host = new Host();
            var gazePointDataStream = host.Streams.CreateGazePointDataStream();
            gazePointDataStream.GazePoint((gazePointX, gazePointY, _) => {
                lastx = (float)gazePointX;
                lasty = (float)gazePointY;
                last10x[numSet] = gazePointX;
                last10y[numSet] = gazePointY;
                numSet = numSet + 1;
                if (numSet > 9)
                {
                    average = last10x.Average();
                    sumOfSquaresOfDifferences = last10x.Select(val => (val - average) * (val - average)).Sum();
                    sdx = Math.Sqrt(sumOfSquaresOfDifferences / last10x.Length);
                    average = last10y.Average();
                    sumOfSquaresOfDifferences = last10y.Select(val => (val - average) * (val - average)).Sum();
                    sdy = Math.Sqrt(sumOfSquaresOfDifferences / last10y.Length);
                    
                    for (int i = 0; i <9; i++)
                    {
                        last10sdx[i] = last10sdx[i + 1];
                        last10sdy[i] = last10sdy[i + 1];
                    }
                    last10sdx[9] = (float)sdx;
                    last10sdy[9] = (float)sdy;
                    numSet = 0;
                    //Console.WriteLine("X: {0} Y:{1}", last10sdx[0], last10sdy[0]);
                }
                //Console.WriteLine("X: {0} Y:{1}", last10sdx[0], last10sdy[0]);
                var message = new SharpOSC.OscMessage("/wek/inputs", last10sdx[0], last10sdx[1], last10sdx[2], last10sdx[3], last10sdx[4], last10sdx[5], last10sdx[6], last10sdx[7], last10sdx[8], last10sdx[9],
                last10sdy[0], last10sdy[1], last10sdy[2], last10sdy[3], last10sdy[4], last10sdy[5], last10sdy[6], last10sdy[7], last10sdy[8], last10sdy[9]);
                //var message = new SharpOSC.OscMessage("/wek/inputs", last10sdx[0]);
                

                sender.Send(message);
                sender2.Send(message);
                
                //Console.WriteLine("X: {0} Y:{1}", gazePointX, gazePointY);
            });


            //Console.WriteLine("X: {0} Y:{1}", gazePointX, gazePointY));


            SharpOSC.HandleOscPacket callback = delegate (SharpOSC.OscPacket packet)
            {
                var messageReceived = (SharpOSC.OscMessage)packet;
                int receivedMessage = Int32.Parse(messageReceived.Arguments[0].ToString());
                
                //if (messageReceived.Arguments[0] == 2)
                if (receivedMessage ==2)
                {
                    clickCounter++;
                    if(clickCounter > 100)
                    {
                        clickCounter = 0;
                        noClick = 0;
                        Console.WriteLine("Sent Coordinates!");
                        Console.WriteLine("Class: {0}", messageReceived.Arguments[0]);
                        var message2 = new SharpOSC.OscMessage("/wek/outputs", lastx, lasty);
                        sender3.Send(message2);
                    }

                }
                else
                {
                    noClick = noClick + 1;
                    if (noClick == 40)
                    {
                        noClick = 0;
                        clickCounter = 0;
                    }
                }
            };

            var listener = new SharpOSC.UDPListener(12002, callback);

            ///Console.WriteLine("Press enter to stop");


            while (true)
            { }
        }
    }
}
