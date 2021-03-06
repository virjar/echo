package com.virjar.echo.nat.server.portal;

import com.alibaba.fastjson.JSONObject;
import com.virjar.echo.nat.cmd.CmdHandler;
import com.virjar.echo.nat.server.EchoNatServer;
import com.virjar.echo.server.common.hserver.HttpActionHandler;
import com.virjar.echo.server.common.hserver.NanoUtil;
import fi.iki.elonen.NanoHTTPD;
import org.apache.commons.lang3.StringUtils;

public class AndroidReDialHandler implements HttpActionHandler {
    private final EchoNatServer echoNatServer;

    public AndroidReDialHandler(EchoNatServer echoNatServer) {
        this.echoNatServer = echoNatServer;
    }

    @Override
    public JSONObject handle(NanoHTTPD.IHTTPSession httpSession) {
        String clientId = NanoUtil.getParam("clientId", httpSession);
        if (StringUtils.isBlank(clientId)) {
            return NanoUtil.failed(-1, "need param:{clientId}");
        }


        return echoNatServer.getEchoRemoteControlManager()
                .sendRemoteControlMessage(clientId, CmdHandler.ACTION_ANDROID_REDIAL, "");
    }
}
