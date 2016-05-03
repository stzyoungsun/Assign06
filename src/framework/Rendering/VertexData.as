package framework.Rendering
{
    public class VertexData 
    {
		private var _rawData:Vector.<Number>;
		
        public static const ELEMENTS_PER_VERTEX:int = 9;
        public static const POSITION_OFFSET:int = 0;
		public static const COLOR_OFFSET:int = 3;
        public static const TEXCOORD_OFFSET:int = 7;
        
        public function VertexData(numVertices:int)
        {            
			_rawData = new Vector.<Number>(numVertices * ELEMENTS_PER_VERTEX, true);
        }
        
        public function setPosition(vertexID:int, x:Number, y:Number, z:Number=0.0):void
        {
            setValues(getOffset(vertexID) + POSITION_OFFSET, x, y, z);
        }
        
		public function setColor(vertexID:int, color:uint):void
		{
			setValues(getOffset(vertexID) + COLOR_OFFSET, 
				(color >> 16) & 0xff / 255.0,
				(color >> 8) & 0xff / 255.0,
				color & 0xff / 255.0,
				1.0);
		}
		
		public function setTexCoords(vertexID:int, u:Number, v:Number):void
		{
			setValues(getOffset(vertexID) + TEXCOORD_OFFSET, u, v);
		}
		
		public function setUniformColor(color:uint):void
		{
			for (var i:int=0; i < numVertices; i++)
			{
				setColor(i, color);
			}
		}
        
        public function clone():VertexData
        {
            var clone:VertexData = new VertexData(0);
            clone._rawData = _rawData.concat();
            clone._rawData.fixed = true;
            return clone;
        }
        
        private function setValues(offset:int, ...values):void
        {
            var numValues:int = values.length;
            for (var i:int = 0; i < numValues; i++)
			{
				_rawData[offset + i] = values[i];
			}
        }
        
        private function getOffset(vertexID:int):int
        {
            return vertexID * ELEMENTS_PER_VERTEX;
        }
        
        public function get numVertices():int { return _rawData.length / ELEMENTS_PER_VERTEX; }
        public function get data():Vector.<Number> { return _rawData; }
    }
}