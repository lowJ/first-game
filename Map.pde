class Map{
  String name;
  String type;
  Map(int[][]tiles, String mapType){
    this.type = mapType;
    initMap();
  }
  void initMap(){
    for(int r = 0; r < tiles.length; r ++){
      for(int c = 0; c < tiles[0].length; c++){
        if(tiles[r][c] == 1){
          GameTile til = new GameTile(c * 70, r * 70, type, "03");// fix?
          map.add(til);
        }
        if(tiles[r][c] == 2){
          GameTile til = new GameTile(c * 70, r * 70, type, "16");// fix?
          map.add(til);
        }
        if(tiles[r][c] == 3){ //left edge
          GameTile til = new GameTile(c * 70, r * 70, type, "14");// fix?
          map.add(til);
        }
        if(tiles[r][c] == 4){ //right edge
          GameTile til = new GameTile(c * 70, r * 70, type, "15");// fix?
          map.add(til);
        }
      }
    }
  }
}