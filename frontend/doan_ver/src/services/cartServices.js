import requestApi from "../utils/requestApi";

const user = JSON.parse(localStorage.getItem("currentUser"))?.data;
const token = JSON.parse(localStorage.getItem("token"));

// Thêm mới 1 order detail
export const addProductToCartService = async (dataCart) => {
    let data = dataCart.data;
    let idOrder = "";
    try {
        const respon = await getOrderNotPayment(dataCart.accessToken);
        if (respon.status === 400) {
            const _respon = await createNewOrrder(dataCart.accessToken);
            idOrder = _respon.data.id;
        } else {
            idOrder = respon.data.id;
        }
        data = { ...data, idOrder };
        const respon_1 = await createNewDetailOrrder(dataCart.accessToken, data);
        return {
            result: respon_1,
            idOrder
        };

    } catch (error) {
        return error;
    }
};
export const createNewDetailOrrder = async (accessToken, _data) => {
    try {
        const respone = await requestApi({
            method: "post",
            url: `order/detail/add`,
            headers: {
                "Content-Type": "application/json",
                Authorization: accessToken,
            },
            data: JSON.stringify(_data),
        });
        return respone.data;
    } catch (error) {
        return error.response.data
    }
}
//Tạo mới 1 order
export const createNewOrrder = async (accessToken) => {
    const _data = {
        idUser: user.id
    }
    try {
        const respone = await requestApi({
            method: "post",
            url: `order/add`,
            headers: {
                "Content-Type": "application/json",
                Authorization: accessToken,
            },
            data: JSON.stringify(_data),
        });
        return respone.data;
    } catch (error) {
        return error.response.data
    }
}
//lấy order chưa thanh toán
export const getOrderNotPayment = async (accessToken) => {

    try {
        const respone = await requestApi({
            method: "get",
            url: `order/getOrderNotPay?idUser=${user.id}`,
            headers: {
                Authorization: accessToken,
            },
        });
        return respone.data;
    } catch (error) {
        return error.response.data
    }
}
//Lấy danh sách detail order
export const getAllCartItemService = async (accessToken) => {
    try {
        const idOrder = (await getOrderNotPayment(accessToken))?.data.id;
        const respone = await requestApi({
            method: "get",
            url: `order/detail/getAllByOrder?idOrder=${idOrder}`,
            headers: {
                Authorization: accessToken,
            },
        });
        return respone.data;
    } catch (error) {
        return error.response.data
    }
};
//Xóa 1 detail order
export const deleteCartItemService = async (id) => {
    try {
        const respone = await requestApi({
            method: "delete",
            url: `order/detail/delete`,
            headers: {
                "Content-Type": "application/json",
                Authorization: token,
            },
            data: JSON.stringify(id),
        });
        return respone;
    } catch (error) {
        return error
    }
};

// Tăng lên 1 đơn vị
export const increaseItemService = async (id) => {
    try {
        const respone = await requestApi({
            method: "put",
            url: `order/detail/increase`,
            headers: {
                "Content-Type": "application/json",
                Authorization: token,
            },
            data: JSON.stringify(id),
        });
        return respone;
    } catch (error) {
        return error
    }
}
// Giảm xuống 1 đơn vị
export const decreaseItemService = async (id) => {
    try {
        const respone = await requestApi({
            method: "put",
            url: `order/detail/decrease`,
            headers: {
                "Content-Type": "application/json",
                Authorization: token,
            },
            data: JSON.stringify(id),
        });
        return respone;
    } catch (error) {
        return error
    }
}