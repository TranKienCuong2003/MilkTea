<script src="js/jquery-3.6.0.min.js"></script>
<script src="js/bootstrap.bundle.min.js"></script>
<script src="js/script.js"></script>

<style>
  /* Chatbot Container */
  .chatbot-container {
    position: fixed;
    bottom: 24px;
    right: 24px;
    z-index: 1000;
    width: 370px;
    max-width: 95vw;
    height: 540px;
    background: #fff;
    border-radius: 20px;
    box-shadow: 0 8px 32px rgba(44, 62, 80, 0.18),
      0 1.5px 6px rgba(44, 62, 80, 0.08);
    display: flex;
    flex-direction: column;
    overflow: hidden;
    transition: all 0.3s cubic-bezier(0.4, 2, 0.3, 1);
  }

  /* Chatbot Header */
  .chatbot-header {
    background: linear-gradient(135deg, #4caf50 60%, #2196f3 100%);
    color: white;
    padding: 18px 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    box-shadow: 0 2px 8px rgba(44, 62, 80, 0.08);
  }

  .chatbot-header h3 {
    margin: 0;
    font-size: 20px;
    font-weight: 700;
    letter-spacing: 1px;
    display: flex;
    align-items: center;
    gap: 8px;
  }

  .chatbot-header .close-btn {
    background: none;
    border: none;
    color: white;
    font-size: 24px;
    cursor: pointer;
    width: 36px;
    height: 36px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: background 0.2s;
  }

  .chatbot-header .close-btn:hover {
    background: rgba(255, 255, 255, 0.18);
  }

  /* Chat Messages Area */
  .chat-messages {
    flex: 1;
    padding: 24px 18px 18px 18px;
    overflow-y: auto;
    background: #f7fafd;
    scroll-behavior: smooth;
  }

  /* Message Bubbles */
  .message {
    margin-bottom: 18px;
    display: flex;
    flex-direction: column;
    animation: fadeInUp 0.4s cubic-bezier(0.4, 2, 0.3, 1);
  }

  @keyframes fadeInUp {
    from {
      opacity: 0;
      transform: translateY(30px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  .message.user-message {
    align-items: flex-end;
  }

  .message.bot-message {
    align-items: flex-start;
  }

  .message-content {
    max-width: 85%;
    padding: 14px 18px;
    border-radius: 18px;
    font-size: 15px;
    line-height: 1.6;
    position: relative;
    box-shadow: 0 2px 8px rgba(44, 62, 80, 0.07);
    word-break: break-word;
    background: #fff;
    margin-top: 2px;
  }

  .user-message .message-content {
    background: linear-gradient(135deg, #4caf50 70%, #2196f3 100%);
    color: white;
    border-bottom-right-radius: 8px;
    box-shadow: 0 2px 12px rgba(76, 175, 80, 0.1);
  }

  .bot-message .message-content {
    background: #fff;
    color: #333;
    border-bottom-left-radius: 8px;
    box-shadow: 0 2px 8px rgba(44, 62, 80, 0.07);
  }

  /* Avatar */
  .bot-avatar,
  .user-avatar {
    width: 38px;
    height: 38px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    margin-right: 10px;
    margin-top: 2px;
    box-shadow: 0 2px 8px rgba(44, 62, 80, 0.1);
    border: 2.5px solid #e3eaf1;
    background: #f7fafd;
  }
  .user-avatar {
    margin-left: 10px;
    margin-right: 0;
    border: 2.5px solid #2196f3;
    background: #e3f2fd;
    box-shadow: 0 2px 12px rgba(33, 150, 243, 0.1);
  }
  .user-avatar img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 50%;
  }

  /* Tên người gửi */
  .sender-name {
    font-size: 13px;
    color: #888;
    margin: 0 8px;
    margin-bottom: 2px;
    font-weight: 500;
  }
  .user-message .sender-name {
    text-align: right;
    width: 100%;
    margin-right: 8px;
    margin-left: 0;
    margin-bottom: 2px;
    font-size: 13px;
    color: #2196f3;
    font-weight: 600;
  }

  /* Input Area */
  .chat-input {
    padding: 16px 18px;
    background: #f7fafd;
    border-top: 1px solid #e3eaf1;
    display: flex;
    align-items: center;
    gap: 12px;
  }

  .chat-input input {
    flex: 1;
    padding: 13px 18px;
    border: 1.5px solid #e3eaf1;
    border-radius: 25px;
    font-size: 15px;
    outline: none;
    transition: border-color 0.3s;
    background: #fff;
    color: #222;
    box-shadow: 0 1px 4px rgba(44, 62, 80, 0.04);
  }

  .chat-input input:focus {
    border-color: #4caf50;
    background: #f1fff1;
  }

  .chat-input button {
    background: linear-gradient(135deg, #4caf50 70%, #2196f3 100%);
    color: white;
    border: none;
    width: 44px;
    height: 44px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: box-shadow 0.2s, transform 0.2s;
    box-shadow: 0 2px 8px rgba(44, 62, 80, 0.1);
    position: relative;
    overflow: hidden;
  }

  .chat-input button:hover {
    box-shadow: 0 4px 16px rgba(33, 150, 243, 0.18);
    transform: scale(1.08);
  }

  .chat-input button:active::after {
    content: "";
    position: absolute;
    left: 50%;
    top: 50%;
    width: 120%;
    height: 120%;
    background: rgba(33, 150, 243, 0.08);
    border-radius: 50%;
    transform: translate(-50%, -50%) scale(1.2);
    animation: ripple 0.4s linear;
    z-index: 1;
  }
  @keyframes ripple {
    from {
      opacity: 0.5;
    }
    to {
      opacity: 0;
    }
  }

  /* Loading Animation */
  .loading {
    display: flex;
    align-items: center;
    gap: 5px;
    color: #666;
    font-style: italic;
  }

  .loading::after {
    content: "";
    width: 14px;
    height: 14px;
    border: 2.5px solid #4caf50;
    border-radius: 50%;
    border-top-color: transparent;
    animation: spin 1s linear infinite;
  }

  @keyframes spin {
    to {
      transform: rotate(360deg);
    }
  }

  /* More Button */
  .more-button {
    margin-top: 12px;
    padding: 9px 18px;
    background: linear-gradient(135deg, #4caf50 70%, #2196f3 100%);
    color: white;
    border: none;
    border-radius: 20px;
    cursor: pointer;
    font-size: 14px;
    transition: all 0.3s;
    box-shadow: 0 2px 8px rgba(44, 62, 80, 0.1);
    font-weight: 500;
    letter-spacing: 0.5px;
  }

  .more-button:hover {
    background: linear-gradient(135deg, #2196f3 70%, #4caf50 100%);
    transform: translateY(-1px) scale(1.04);
    box-shadow: 0 4px 16px rgba(33, 150, 243, 0.15);
  }

  /* Scrollbar Styling */
  .chat-messages::-webkit-scrollbar {
    width: 7px;
  }

  .chat-messages::-webkit-scrollbar-track {
    background: #e3eaf1;
    border-radius: 8px;
  }

  .chat-messages::-webkit-scrollbar-thumb {
    background: #b2becd;
    border-radius: 8px;
  }

  .chat-messages::-webkit-scrollbar-thumb:hover {
    background: #2196f3;
  }

  /* Chat Toggle Button */
  .chat-toggle {
    position: fixed;
    bottom: 60px;
    right: 24px;
    width: 64px;
    height: 64px;
    background: linear-gradient(135deg, #4caf50 70%, #2196f3 100%);
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: grab;
    box-shadow: 0 6px 24px rgba(44, 62, 80, 0.18);
    transition: all 0.3s;
    z-index: 999;
  }

  .chat-toggle:hover {
    transform: scale(1.08);
    background: linear-gradient(135deg, #2196f3 70%, #4caf50 100%);
  }

  .chat-toggle:active {
    cursor: grabbing;
  }

  .chat-toggle i {
    color: white;
    font-size: 28px;
  }

  /* Welcome Message */
  .welcome-message {
    text-align: center;
    padding: 24px 0 12px 0;
    color: #666;
  }

  .welcome-message h4 {
    color: #4caf50;
    margin-bottom: 10px;
    font-size: 18px;
  }

  .welcome-message p {
    font-size: 14px;
    line-height: 1.5;
  }

  @media (max-width: 600px) {
    .chatbot-container {
      width: 98vw;
      height: 90vh;
      right: 1vw;
      bottom: 1vw;
      border-radius: 12px;
    }
    .chat-toggle {
      width: 54px;
      height: 54px;
      right: 2vw;
      bottom: 2vw;
    }
    .chatbot-header {
      padding: 12px 10px;
    }
    .chat-messages {
      padding: 12px 6px 8px 6px;
    }
    .chat-input {
      padding: 10px 6px;
    }
  }

  .chat-toggle.opened {
    opacity: 0.4;
    pointer-events: none;
    transition: opacity 0.2s;
  }
</style>

<!-- Chat Toggle Button -->
<div class="chat-toggle" onclick="toggleChat()">
  <i class="fas fa-comments"></i>
</div>

<!-- Chatbot Container -->
<div class="chatbot-container" id="chatbotContainer" style="display: none">
  <div class="chatbot-header">
    <h3>Milk Tea Assistant</h3>
    <button class="close-btn" onclick="toggleChat()">×</button>
  </div>
  <div class="chat-messages" id="chatMessages">
    <div class="welcome-message">
      <h4>👋 Xin chào!</h4>
      <p>Tôi là trợ lý ảo của Milk Tea Shop. Tôi có thể giúp bạn:</p>
      <p>
        • Tìm hiểu về menu và sản phẩm<br />
        • Tư vấn về topping và size<br />
        • Thông tin về khuyến mãi<br />
        • Giải đáp thắc mắc
      </p>
    </div>
  </div>
  <div class="chat-input">
    <input
      type="text"
      id="messageInput"
      placeholder="Nhập tin nhắn của bạn..."
      onkeypress="handleKeyPress(event)"
    />
    <button onclick="sendMessage()">
      <i class="fas fa-paper-plane"></i>
    </button>
  </div>
</div>

<%-- Lấy họ tên người dùng từ session (giả sử lưu ở fullName) --%>
<script>
  var userFullName =
    '<%= session.getAttribute("fullName") != null ? session.getAttribute("fullName") : "Bạn" %>';
  var userAvatar =
    '<%= session.getAttribute("avatar") != null ? session.getAttribute("avatar") : "/resources/images/avatars/users-icon.jpg" %>';
</script>

<script>
  // ... existing JavaScript code ...

  // Thêm hàm xử lý phím Enter
  function handleKeyPress(event) {
    if (event.key === "Enter") {
      sendMessage();
    }
  }

  // Thêm hàm toggle chat
  function toggleChat() {
    const container = document.getElementById("chatbotContainer");
    const toggle = document.querySelector(".chat-toggle");

    if (container.style.display === "none") {
      container.style.display = "flex";
      toggle.classList.add("opened");
    } else {
      container.style.display = "none";
      toggle.classList.remove("opened");
    }
  }

  // Hàm lưu lịch sử chat vào localStorage
  function saveChatHistory() {
    const chatMessages = document.getElementById("chatMessages");
    localStorage.setItem("chatHistory", chatMessages.innerHTML);
  }

  // Hàm khôi phục lịch sử chat từ localStorage
  function restoreChatHistory() {
    const chatMessages = document.getElementById("chatMessages");
    const history = localStorage.getItem("chatHistory");
    if (history) {
      chatMessages.innerHTML = history;
    } else {
      // Nếu không có lịch sử, hiển thị tin nhắn chào mừng như cũ
      const welcomeDiv = document.createElement("div");
      welcomeDiv.className = "message bot-message welcome-message";
      welcomeDiv.innerHTML = `
        <div class="bot-avatar"><i class="fas fa-robot"></i></div>
        <div class="sender-name"><strong>Milk Tea Shop Bot</strong></div>
        <div class="message-content">
          Xin chào! Tôi là Milk Tea Bot. Tôi có thể giúp gì cho bạn?
        </div>
      `;
      chatMessages.appendChild(welcomeDiv);
    }
  }

  // Gọi khôi phục lịch sử chat khi load trang
  window.addEventListener("DOMContentLoaded", function () {
    restoreChatHistory();
  });

  // Sửa addMessage để lưu lịch sử chat sau khi thêm tin nhắn
  function addMessage(message, sender, isError = false) {
    const messageDiv = document.createElement("div");
    messageDiv.className = `message ${sender}-message`;

    // Tạo avatar và tên
    let avatarDiv = document.createElement("div");
    let nameDiv = document.createElement("div");
    nameDiv.className = "sender-name";

    if (sender === "bot") {
      avatarDiv.className = "bot-avatar";
      avatarDiv.innerHTML = '<i class="fas fa-robot"></i>';
      nameDiv.innerHTML = "<strong>Milk Tea Shop Bot</strong>";
    } else {
      avatarDiv.className = "user-avatar";
      avatarDiv.innerHTML = `<img src="${userAvatar}" alt="avatar">`;
      nameDiv.textContent = userFullName || "Bạn";
    }

    // Nội dung tin nhắn
    const contentDiv = document.createElement("div");
    contentDiv.className = "message-content";
    if (isError) {
      contentDiv.style.backgroundColor = "#ff4444";
      contentDiv.style.color = "white";
    }
    contentDiv.textContent = message;

    // Sắp xếp layout trái/phải
    if (sender === "bot") {
      messageDiv.appendChild(avatarDiv);
      messageDiv.appendChild(nameDiv);
      messageDiv.appendChild(contentDiv);
    } else {
      messageDiv.appendChild(avatarDiv);
      messageDiv.appendChild(nameDiv);
      messageDiv.appendChild(contentDiv);
    }

    chatMessages.appendChild(messageDiv);

    // Animation
    messageDiv.style.opacity = "0";
    messageDiv.style.transform = "translateY(20px)";
    messageDiv.style.transition = "all 0.3s ease";
    setTimeout(() => {
      messageDiv.style.opacity = "1";
      messageDiv.style.transform = "translateY(0)";
    }, 50);

    chatMessages.scrollTop = chatMessages.scrollHeight;
    saveChatHistory(); // Lưu lịch sử chat sau khi thêm tin nhắn
    return messageDiv;
  }

  // Sửa loadMoreChunks để lưu lịch sử chat sau khi thêm đoạn mới
  function loadMoreChunks(
    originalMessage,
    chunkIndex,
    totalChunks,
    messageDiv
  ) {
    // Hiển thị loading
    const loadingText = document.createElement("div");
    loadingText.className = "loading";
    loadingText.textContent = "Đang tải thêm...";
    messageDiv.querySelector(".message-content").appendChild(loadingText);

    // Gửi request để lấy đoạn tiếp theo
    fetch("/api/chatbot/send", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        message: originalMessage,
        chunkIndex: chunkIndex,
      }),
    })
      .then((response) => response.json())
      .then((data) => {
        // Xóa loading
        messageDiv.querySelector(".loading").remove();

        if (data.error) {
          addMessage(data.error, "bot", true);
          return;
        }

        // Thêm nội dung mới vào tin nhắn hiện tại
        const messageContent = messageDiv.querySelector(".message-content");
        messageContent.innerHTML += "<br>" + data.message;

        // Cập nhật nút "Xem thêm" nếu còn đoạn tiếp theo
        if (chunkIndex < totalChunks) {
          const moreButton = document.createElement("button");
          moreButton.className = "more-button";
          moreButton.textContent = "Xem thêm";
          moreButton.onclick = () =>
            loadMoreChunks(
              originalMessage,
              chunkIndex + 1,
              totalChunks,
              messageDiv
            );
          messageContent.appendChild(moreButton);
        }

        // Cuộn xuống cuối
        chatMessages.scrollTop = chatMessages.scrollHeight;
        saveChatHistory(); // Lưu lịch sử chat sau khi thêm đoạn mới
      })
      .catch((error) => {
        console.error("Error:", error);
        messageDiv.querySelector(".loading").remove();
        addMessage(
          "Có lỗi xảy ra khi tải thêm nội dung. Vui lòng thử lại sau!",
          "bot",
          true
        );
      });
  }

  // Khi logout, xóa lịch sử chat
  function clearChatHistory() {
    localStorage.removeItem("chatHistory");
  }
</script>
