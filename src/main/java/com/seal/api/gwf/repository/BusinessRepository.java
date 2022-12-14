package com.seal.api.gwf.repository;

import com.seal.api.gwf.entity.BusinessEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public interface BusinessRepository extends JpaRepository<BusinessEntity, Integer> {
    @Query(value = "SELECT * FROM Business WHERE BusinessID = ?1", nativeQuery = true)
    BusinessEntity getByID(int id);

    @Query(value = "SELECT * FROM Business WHERE AccountID = ?1", nativeQuery = true)
    List<BusinessEntity> getByAccountID(int id);
    @Query(value = "SELECT * FROM Business",nativeQuery = true)
    List<BusinessEntity> getAll();

    @Query(value = "SELECT * FROM Business WHERE AccountID = ?1", nativeQuery = true)
    List<BusinessEntity> getAllBusinessAddress(int id);

    @Modifying
    @Query(value = "INSERT INTO Business VALUES (:location, :accountID, :address, :businessName, :businessLogo, :description, :benefit)", nativeQuery = true)
    @Transactional
    Integer addBusiness(Integer location, Integer accountID, String address, String businessName, String businessLogo, String description, String benefit);


    @Modifying
    @Query(value = """
            UPDATE Business
            SET LocationID = ?2, Address = ?3, BusinessName = ?4, BusinessLogo = ?5, Description = ?6, Benefit = ?7
            WHERE BusinessID = ?1 AND AccountID = ?8""",nativeQuery = true)
    @Transactional
    int updateBusiness(int businessID, Integer locationID, String address, String businessName, String link, String description, String benefit, int accountID);


}
