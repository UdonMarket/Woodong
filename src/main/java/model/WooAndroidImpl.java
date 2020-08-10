package model;

import org.springframework.stereotype.Service;

@Service
public interface WooAndroidImpl {

   public int WoolocationSave(WooAndroidVO vo);
   
   public int WoolocationUpdate(WooAndroidVO vo);
   
   public WooAndroidVO WoolocationSelect(WooAndroidVO vo);
   
   public int WoolocationDelete(WooAndroidVO vo);
   
   public int checkmember(WooAndroidVO vo);
}