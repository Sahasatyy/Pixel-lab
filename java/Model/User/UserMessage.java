package Model.User;

public class UserMessage {
    private String messageContent;
    private String messageType;
    private String messageCssClass;

    public UserMessage(String messageContent, String messageType, String messageCssClass) {
        this.messageContent = messageContent;
        this.messageType = messageType;
        this.messageCssClass = messageCssClass;
    }

    public String getMessageContent() {
        return messageContent;
    }

    public void setMessageContent(String messageContent) {
        this.messageContent = messageContent;
    }

    public String getMessageType() {
        return messageType;
    }

    public void setMessageType(String messageType) {
        this.messageType = messageType;
    }

    public String getMessageCssClass() {
        return messageCssClass;
    }

    public void setMessageCssClass(String messageCssClass) {
        this.messageCssClass = messageCssClass;
    }
}