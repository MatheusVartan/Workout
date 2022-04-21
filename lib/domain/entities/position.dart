class Position {
  double x, y;
  Position(this.x, this.y);
}

Position getAdjustedXandY(x, y, screenH, screenW, previewH, previewW) {
  var scaleW, scaleH;
  if (screenH / screenW > previewH / previewW) {
    scaleW = screenH / previewH * previewW;
    scaleH = screenH;
    var difW = (scaleW - screenW) / scaleW;
    return Position((x - difW / 2) * scaleW, y * scaleH);
  } else {
    scaleH = screenW / previewW * previewH;
    scaleW = screenW;
    var difH = (scaleH - screenH) / scaleH;
    return Position(x * scaleW, (y - difH / 2) * scaleH);
  }
}