%ifndef MIXINS_ASM
%define MIXINS_ASM

  %define BREAK xchg bx, bx

  %define LINE_FEED 10
  %define CARRIAGE_RETURN 13
  %define CRLF CARRIAGE_RETURN,LINE_FEED
  %define NULL 0

%endif
