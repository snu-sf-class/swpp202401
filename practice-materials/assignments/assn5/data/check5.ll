define i4 @main(i4 %x, i4 %y, i4 %b) {
; CHECK-LABEL: @main(i4 %x, i4 %y, i4 %b)
; CHECK-NEXT:    [[A:%.*]] = add i4 [[X:%.*]], [[Y:%.*]]
; CHECK-NEXT:    [[COND:%.*]] = icmp eq i4 [[A]], [[B:%.*]]
; CHECK-NEXT:    br i1 [[COND]], label [[BB_TRUE:%.*]], label [[BB_FALSE:%.*]]
; CHECK:       bb_true:
; CHECK-NEXT:    call void @f(i4 [[B]], i4 [[B]])
; CHECK-NEXT:    br label [[BB_EXIT:%.*]]
; CHECK:       bb_false:
; CHECK-NEXT:    call void @g(i4 [[A]], i4 [[B]])
; CHECK-NEXT:    br label [[BB_EXIT]]
; CHECK:       bb_exit:
; CHECK-NEXT:    call void @g(i4 [[A]], i4 [[B]])
; CHECK-NEXT:    ret i4 [[B]]
;
  %a = add i4 %x, %y
  %cond = icmp eq i4 %a, %b
  br i1 %cond, label %bb_true, label %bb_false
bb_true:
  call void @f(i4 %a, i4 %b)
  br label %bb_exit
bb_false:
  call void @g(i4 %a, i4 %b)
  br label %bb_exit
bb_exit:
  call void @g(i4 %a, i4 %b)
  ret i4 %b
}

declare void @f(i4, i4)
declare void @g(i4, i4)
