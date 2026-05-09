import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/features/startups/domain/startup.dart';

class PrivateQuestionsChatScreen extends StatefulWidget {
  final StartupDetail startup;

  const PrivateQuestionsChatScreen({super.key, required this.startup});

  @override
  State<PrivateQuestionsChatScreen> createState() =>
      _PrivateQuestionsChatScreenState();
}

class _PrivateQuestionsChatScreenState
    extends State<PrivateQuestionsChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_PrivateChatMessage> _messages = [];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC),
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF4B5563)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Perguntas privadas',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildStartupHeader(),
          Expanded(
            child: _messages.isEmpty
                ? _buildEmptyState()
                : ListView.separated(
                    controller: _scrollController,
                    padding: const EdgeInsets.fromLTRB(30, 26, 24, 24),
                    itemCount: _messages.length,
                    separatorBuilder: (_, index) => const SizedBox(height: 22),
                    itemBuilder: (context, index) {
                      return _buildMessageBubble(_messages[index]);
                    },
                  ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildStartupHeader() {
    final startupName = widget.startup.name.trim();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(30, 18, 30, 18),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFBFF),
        border: Border(bottom: BorderSide(color: Color(0xFFEDE7F6), width: 1)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(
              Icons.lock_outline,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (startupName.isNotEmpty) ...[
                  Text(
                    startupName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                ],
                const Text(
                  'Chat restrito para investidores',
                  style: TextStyle(
                    color: Color(0xFF6200EE),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: const BoxDecoration(
                color: Color(0xFFF8F0FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chat_bubble_outline,
                color: AppColors.primary,
                size: 36,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Nenhuma pergunta privada ainda.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'As perguntas enviadas por investidores aparecer\u00e3o aqui.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF697386),
                fontSize: 15,
                height: 1.4,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(_PrivateChatMessage message) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bubbleColor = message.isMine ? AppColors.primary : AppColors.white;
    final textColor = message.isMine ? AppColors.white : AppColors.textPrimary;

    return Align(
      alignment: message.isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: message.isMine
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: screenWidth * 0.72),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: bubbleColor,
              borderRadius: BorderRadius.circular(18),
              boxShadow: message.isMine
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Text(
              message.text,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                height: 1.35,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            message.time,
            style: const TextStyle(
              color: Color(0xFF8B95A7),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    final hasText = _messageController.text.trim().isNotEmpty;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 20, 20, 18),
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(top: BorderSide(color: Color(0xFFEDEFF3), width: 1)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 62,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F1F4),
                  borderRadius: BorderRadius.circular(31),
                ),
                alignment: Alignment.center,
                child: TextField(
                  controller: _messageController,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: 'Escreva sua mensagem...',
                    hintStyle: TextStyle(
                      color: Color(0xFF697386),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            SizedBox(
              width: 58,
              height: 58,
              child: ElevatedButton(
                onPressed: hasText ? _sendMessage : null,
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: hasText
                      ? AppColors.primary
                      : const Color(0xFFD1D5DB),
                  disabledBackgroundColor: const Color(0xFFD1D5DB),
                  padding: EdgeInsets.zero,
                  shape: const CircleBorder(),
                ),
                child: const Icon(
                  Icons.send_outlined,
                  color: AppColors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        _PrivateChatMessage(
          text: text,
          time: _formatTime(DateTime.now()),
          isMine: true,
        ),
      );
      _messageController.clear();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
      );
    });
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _PrivateChatMessage {
  final String text;
  final String time;
  final bool isMine;

  const _PrivateChatMessage({
    required this.text,
    required this.time,
    this.isMine = false,
  });
}
